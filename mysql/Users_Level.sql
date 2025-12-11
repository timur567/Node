use mydb;
show tables;

INSERT INTO Access_Level (ID_Access_Level, Level_Name) VALUES
(0, 'Администратор'),
(0, 'Модератор контента'),
(0, 'Редактор'),
(0, 'Пользователь');

INSERT INTO Privileges (ID_Privileges, Privileges_Name) VALUES
(1, 'Создание пользователей'),
(2, 'Удаление пользователей'),
(3, 'Редактирование прав доступа'),
(4, 'Просмотр всех объектов'),
(5, 'Создание новых записей'),
(6, 'Редактирование своих записей'),
(7, 'Редактирование чужих записей'),
(8, 'Удаление своих записей'),
(9, 'Удаление чужих записей'),
(10, 'Публикация записей'),
(11, 'Архивирование записей'),
(12, 'Просмотр статистики'),
(13, 'Экспорт данных'),
(14, 'Импорт данных'),
(15, 'Настройка системы');

INSERT INTO User (ID_User, Login, Password, User_Name, TelNum, Start_Use, Is_Active, Access_Level_ID_Access_Level) VALUES
(1, 'admin', 'hashed_pass_1', 'Александр Иванов', '+79123456789','2023-01-15', 1, 1),
(2, 'moderator', 'hashed_pass_2', 'Елена Петрова', '+79234567890','2023-03-22', 1, 2),
(3, 'editor1', 'hashed_pass_3', 'Дмитрий Сидоров', '+79345678901','2022-12-01', 0, 3),
(4, 'editor2', 'hashed_pass_4', 'Ольга Кузнецова', '+79456789012','2024-06-10', 1, 3),
(5, 'user1', 'hashed_pass_5', 'Николай Федоров', '+79567890123','2025-12-08', 0, 4);

INSERT INTO User (ID_User, Login, Password, User_Name, TelNum, Start_Use, Is_Active, Access_Level_ID_Access_Level) VALUES
(6, null, 'hashed_pass_5', 'Николай Федоров', '+79567890123','2022-12-08', 1, 4);

INSERT INTO Access_Level_has_Privileges (Access_Level_ID_Access_Level, Privileges_ID_Privileges) VALUES --  Уровень 1 — Администратор (все привилегии)
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(1, 11), (1, 12), (1, 13), (1, 14), (1, 15);

INSERT INTO Access_Level_has_Privileges (Access_Level_ID_Access_Level, Privileges_ID_Privileges) VALUES -- Уровень 2 — Модератор контента (почти все, кроме управления пользователями и настройками)
(2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12), (2, 13);

INSERT INTO Access_Level_has_Privileges (Access_Level_ID_Access_Level, Privileges_ID_Privileges) VALUES -- Уровень 3 — Редактор (создание, редактирование своих, публикация)
(3, 4), (3, 5), (3, 6), (3, 8), (3, 10);

INSERT INTO Access_Level_has_Privileges (Access_Level_ID_Access_Level, Privileges_ID_Privileges) VALUES -- Уровень 4 — Пользователь (только просмотр)
(4, 4);

-- Блок А: Базовые операции выборки и модификации
-- 1. Выберите всех активных пользователей, отсортированных по фамилии.
SELECT * 
	FROM User
		ORDER BY User_Name;
        
-- 2. Выберите всех пользователей, которые ни разу не логинились 
SELECT * 
	FROM User
		WHERE Login IS NULL;
        
-- 3. Обновите email(Номер телефона) для пользователя с определенным username.
SET SQL_SAFE_UPDATES = 0; -- Отключение безопасного режима
        
UPDATE User SET TelNum = '+79876543211'
	WHERE User_Name = 'Дмитрий Сидоров';

SELECT * -- Проверка
	FROM User;
    
-- 4. Деактивируйте (is_active = FALSE) всех пользователей, зарегистрированных более года назад (используйте DATE_SUB или INTERVAL).
UPDATE User
SET Is_Active = 0
WHERE Start_Use < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Блок B: Работа с JOIN (ключевой блок для понимания RBAC)
-- 5. Выведите список всех пользователей с их ролями. Формат: Имя Фамилия | Роль1, Роль2. (Потребуется JOIN + GROUP_CONCAT)
SELECT u.User_Name AS `Имя Фамилия`, al.Level_Name AS `Роль`
	FROM User u
		LEFT JOIN Access_Level al ON u.ID_User = al.User_ID_User
			ORDER BY u.User_Name;
            
-- 6. Выведите список всех прав для конкретной роли (например, editor). Формат: Название роли | Код права | Описание права. 
 SELECT al.Level_Name AS `Название роли`, p.Privileges_Name AS `Код права`, p.Privileges_Name AS `Описание права`
	FROM Access_Level al
		JOIN Access_Level_has_Privileges alp ON al.ID_Access_Level = alp.Access_Level_ID_Access_Level
		JOIN Privileges p ON alp.Privileges_ID_Privileges = p.ID_Privileges
-- WHERE al.Level_Name = 'Редактор'
ORDER BY p.Privileges_Name;


        


