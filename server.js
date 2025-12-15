// server.js
const express = require('express');
const mysql = require('mysql2/promise'); 
const path = require('path');

const app = express();
const port = 3000;

// Настройки подключения к БД
const dbConfig = {
  host: 'localhost',
  user: 'timkaTop',
  password: '123_Timka',
  database: 'mydb' 
};

// Middleware
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));

// Роуты
app.get('/', (req, res) => {
  res.redirect('/login');
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

// Роут авторизации
app.post('/login', async (req, res) => {
  const { login, password } = req.body;

  if (!login || !password) {
    return res.status(400).send('❌ Логин и пароль обязательны');
  }

  let connection;
  try {
    connection = await mysql.createConnection(dbConfig);

    const [rows] = await connection.execute(
      'SELECT Login, Password FROM User WHERE Login = ?',[login]
    );

    if (rows.length === 0) {
      return res.status(401).send('❌ Неверный логин!');
    }

    // Проверяем пароль
    const isPasswordValid = password === rows[0].Password;
    console.log(rows);
    if (!isPasswordValid) {
      return res.status(401).send('❌ Неверный пароль!');
    }

    res.send(`<h2>Добро пожаловать, ${login}!</h2><p><a href="/login">← Выйти</a></p>`);
  } catch (err) {
    console.error('Ошибка БД:', err.message);
    res.status(500).send('Ошибка подключения к базе данных');
  } finally {
    if (connection) {
      await connection.end();
    }
  }
});

// Запуск сервера
app.listen(port, () => {
  console.log(`Сервер запущен на http://localhost:${port}`);
});