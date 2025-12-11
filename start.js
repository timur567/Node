const mysql = require("mysql2");
  
const connection = mysql.createConnection({
  host: "localhost",
  user: "timkaTop",
  database: "mydb",
  password: "123_Timka"
});

connection.connect(function(err){
    if (err) {
      return console.error("Ошибка: " + err.message);
    }
    else{
      console.log("Подключение к серверу MySQL успешно установлено");
    }
 });

 connection.query(" SELECT al.Level_Name AS `Название роли`, p.Privileges_Name AS `Код права`, p.Privileges_Name AS `Описание права` FROM Access_Level al JOIN Access_Level_has_Privileges alp ON al.ID_Access_Level = alp.Access_Level_ID_Access_Level JOIN Privileges p ON alp.Privileges_ID_Privileges = p.ID_Privileges ORDER BY p.Privileges_Name;",
  function(err, results, fields) {
    console.log(err);
    console.log(results); // собственно данные
    console.log(fields); // мета-данные полей
});
connection.end();