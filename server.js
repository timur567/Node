// server.js
const express = require('express');
const mysql = require('mysql2/promise');
const cookieParser = require('cookie-parser');
const crypto = require('crypto');
const path = require('path');

const app = express();
const port = 3000;

const dbConfig = {
  host: 'localhost',
  user: 'timkaTop',
  password: '123_Timka',
  database: 'mydb'
};

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// === Генерация токена ===
function generateSessionToken() {
  return crypto.randomBytes(32).toString('base64url').substring(0, 45); 
}

app.get('/', (req, res) => {
  res.redirect('/profile');
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

//login — создание сессии
app.post('/login', async (req, res) => {
  const { login, password } = req.body;
  if (!login || !password) {
    return res.status(400).send('Логин и пароль обязательны');
  }

  let connection;
  try {
    connection = await mysql.createConnection(dbConfig);

    const [users] = await connection.execute(
      'SELECT ID_User, Password FROM User WHERE Login = ?',[login]
    );

    if (users.length === 0 || password !== users[0].Password) {
      return res.status(401).send('Неверный логин или пароль');
    }

    const userId = users[0].ID_User;
    const sessionToken = generateSessionToken();

    // Создаём дату в формате строки (для Created_At VARCHAR(45))
    const now = new Date().toISOString().slice(0, 19).replace('T', ' '); // "YYYY-MM-DD HH:MM:SS"
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 часа

    await connection.execute(
      'INSERT INTO Sessions (Session_hash, Created_At, Expires_At, User_ID_User) VALUES (?, ?, ?, ?)',[sessionToken, now, expiresAt, userId]
    );

    res.cookie('session_token', sessionToken, {
      httpOnly: true,
      secure: false,
      maxAge: 24 * 60 * 60 * 1000,
      path: '/',
      sameSite: 'Lax'
    });

    res.redirect('/profile');

  } catch (err) {
    console.error('Ошибка входа:', err.message);
    res.status(500).send('Ошибка сервера');
  } finally {
    if (connection) await connection.end();
  }
});

// profile — проверка сессии
app.get('/profile', async (req, res) => {
  const sessionToken = req.cookies?.session_token;

  if (!sessionToken) {
    return res.status(401).send('Доступ запрещён. <a href="/login">Войдите</a>');
  }

  let connection;
  try {
    connection = await mysql.createConnection(dbConfig);

    // Ищем сессию по токену и проверяем срок действия
    const [sessions] = await connection.execute(
      'SELECT User_ID_User FROM Sessions WHERE Session_hash = ? AND Expires_At > NOW()',
      [sessionToken]
    );

    if (sessions.length === 0) {
      res.clearCookie('session_token', { path: '/' });
      return res.status(401).send('Сессия истекла. <a href="/login">Войдите снова</a>');
    }

    const userId = sessions[0].User_ID_User;

    const [users] = await connection.execute(
      'SELECT User_Name, Login, Start_Use, TelNum FROM User WHERE ID_User = ?',
      [userId]
    );

    if (users.length === 0) {
      res.clearCookie('session_token', { path: '/' });
      return res.status(401).send('Пользователь не найден. <a href="/login">Войдите снова</a>');
    }

    const user = users[0];
    res.send(`
      <h2>Профиль</h2>
      <p><strong>Имя:</strong> ${user.User_Name || '—'}</p>
      <p><strong>Логин:</strong> ${user.Login}</p>
      <p><strong>Дата регистрации:</strong> ${user.Start_Use || '—'}</p>
      <p><strong>Номер телефона:</strong> ${user.TelNum || '—'}</p>
      <p><a href="/logout">Выйти</a></p>
    `);

  } catch (err) {
    console.error('Ошибка профиля:', err.message);
    res.status(500).send('Ошибка сервера');
  } finally {
    if (connection) await connection.end();
  }
});

//logout — удаление сессии
app.get('/logout', async (req, res) => {
  const sessionToken = req.cookies?.session_token;

  let connection;
  try {
    if (sessionToken) {
      connection = await mysql.createConnection(dbConfig);
      await connection.execute(
        'DELETE FROM Sessions WHERE Session_hash = ?',[sessionToken]
      );
    }
  } catch (err) {
    console.error('Ошибка выхода:', err.message);
  } finally {
    if (connection) await connection.end();
  }

  res.clearCookie('session_token', { path: '/' });
  res.redirect('/login');
});


function buildTree(items, parentId = null) {
  return items
    .filter(item => item.parentId === parentId)
    .map(item => ({
      ...item,
      children: buildTree(items, item.id)
    }));
}

function renderTreeHtml(nodes) {
  if (!nodes || nodes.length === 0) return '';
  let html = '<ul style="list-style: none; padding-left: 20px;">';
  for (const node of nodes) {
    html += `<li>${node.name}`;
    if (node.children && node.children.length > 0) {
      html += renderTreeHtml(node.children);
    }
    html += '</li>';
  }
  html += '</ul>';
  return html;
}

app.get('/categories', async (req, res) => {
  let connection;
    connection = await mysql.createConnection(dbConfig);

    const [rows] = await connection.execute(`
      SELECT 
        ID_Categories AS id,
        Categories_Name AS name,
        CASE 
          WHEN Categories_ID_Categories = 0 THEN NULL 
          ELSE Categories_ID_Categories 
        END AS parentId
      FROM Categories
      ORDER BY ID_Categories
    `);

    const tree = buildTree(rows); // Строим дерево
    const treeHtml = renderTreeHtml(tree); // Генерируем HTML

    res.send(`
      <!DOCTYPE html>
      <html lang="ru">
      <head>
        <meta charset="UTF-8">
        <title>Каталог</title>
      </head>
      <body>
        <h2>Древовидный каталог</h2>
        ${treeHtml || '<p>Категории не найдены</p>'}
        <p><a href="/profile">← Назад в профиль</a></p>
      </body>
      </html>
    `);
});
app.listen(port, () => {
  console.log(`Сервер запущен: http://localhost:${port}`);
  console.log(`Древовидные категории: http://localhost:${port}/categories`);
});