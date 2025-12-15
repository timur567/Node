// server.js
const express = require('express');
const app = express();
const port = 3306;

// Простой GET-роут для корневого пути
app.get('/', (req, res) => {
  res.send('<h1>Веб-сервер работает!</h1>');
});

// Запуск сервера
app.listen(port, () => {
  console.log(`Сервер запущен на http://localhost:${port}`);
});