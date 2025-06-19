-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3312
-- Время создания: Июн 19 2025 г., 03:19
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `hr_integration`
--

-- --------------------------------------------------------

--
-- Структура таблицы `applications`
--

CREATE TABLE `applications` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `vacancy_id` int DEFAULT NULL,
  `resume_text` text,
  `status` enum('new','approved','rejected') DEFAULT 'new',
  `reviewed_by` int DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `applied_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id`, `user_id`, `full_name`, `age`, `experience`, `vacancy_id`, `resume_text`, `status`, `reviewed_by`, `reviewed_at`, `applied_at`) VALUES
(17, 24, 'Григорьев Григорий Григорьевич', 40, 7, 7, 'Готов к переезду', 'approved', 23, '2025-06-08 00:02:47', '2025-06-08 00:01:52'),
(18, 26, 'Дугинов Александр Петрович', 29, 0, 8, 'нет', 'rejected', 23, '2025-06-08 00:07:04', '2025-06-08 00:06:34'),
(19, 28, 'Подгорнова Александра Васильевна', 16, 0, 7, 't1', 'approved', 23, '2025-06-15 22:28:15', '2025-06-15 22:27:53'),
(20, 27, 'Герасимов', 16, 0, 7, 'ффф', 'approved', 23, '2025-06-19 01:37:30', '2025-06-19 01:37:16'),
(21, 30, 'анцурова Татьяная Викторовна', 16, 20, 7, 'о себе', 'approved', 23, '2025-06-19 02:53:59', '2025-06-19 02:42:25'),
(22, 31, 'Григорьева Ксения Андреевна', 30, 0, 7, 'не было опыта работы', 'rejected', 23, '2025-06-19 02:54:04', '2025-06-19 02:43:52'),
(23, 32, 'Елистратов Денис Константинович', 51, 10, 7, 'работал на себя', 'new', NULL, NULL, '2025-06-19 02:45:34');

-- --------------------------------------------------------

--
-- Структура таблицы `attendance`
--

CREATE TABLE `attendance` (
  `id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `login_time` time DEFAULT NULL,
  `status` enum('present','late','absent') NOT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `attendance`
--

INSERT INTO `attendance` (`id`, `employee_id`, `date`, `login_time`, `status`, `notes`) VALUES
(97, 22, '2025-06-07', '00:03:00', 'absent', 'Автоматически создано при входе'),
(98, 22, '2025-06-06', '00:08:00', 'absent', 'Автоматически создано при входе'),
(99, 22, '2025-06-05', '00:09:00', 'absent', 'Автоматически создано при входе'),
(100, 22, '2025-06-01', '00:10:00', 'late', 'Автоматически создано при входе'),
(101, 22, '2025-06-02', '11:11:00', 'absent', 'Автоматически создано при входе'),
(102, 22, '2025-06-08', '11:05:00', 'absent', 'Автоматически создано при входе'),
(103, 24, '2025-06-19', '02:39:00', 'present', 'Автоматически создано при входе'),
(104, 25, '2025-06-19', '02:54:00', 'present', 'Автоматически создано при входе');

--
-- Триггеры `attendance`
--
DELIMITER $$
CREATE TRIGGER `set_attendance_status` BEFORE INSERT ON `attendance` FOR EACH ROW BEGIN
    IF NEW.login_time IS NOT NULL THEN
        IF NEW.login_time <= '09:00:00' THEN
            SET NEW.status = 'present';
        ELSEIF NEW.login_time <= '10:00:00' THEN
            SET NEW.status = 'late';
        ELSE
            SET NEW.status = 'absent';
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `profession` varchar(100) DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `passport_scan_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`id`, `full_name`, `profession`, `photo_path`, `passport_scan_path`, `is_active`, `user_id`) VALUES
(21, 'Иванов', NULL, NULL, NULL, 1, 23),
(22, 'emp', 'Инженер', 'C:/Users/kapra/OneDrive/Изображения/image_1.jpg', NULL, 0, 24),
(23, 'Подгорнова Александра', 'Инженер', NULL, 'C:/Users/kapra/OneDrive/Рабочий стол/49476038-2492844.jpg', 1, 28),
(24, 'test', 'Инженер', NULL, NULL, 1, 27),
(25, 'test1', 'Инженер', NULL, NULL, 1, 30);

-- --------------------------------------------------------

--
-- Структура таблицы `firings`
--

CREATE TABLE `firings` (
  `id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `reason` text,
  `fired_by` int DEFAULT NULL,
  `fired_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `firings`
--

INSERT INTO `firings` (`id`, `employee_id`, `reason`, `fired_by`, `fired_at`) VALUES
(8, 22, 'ppp', NULL, '2025-06-19 01:18:47'),
(9, 22, 'pop', NULL, '2025-06-19 01:54:28'),
(10, 22, 'dfg', NULL, '2025-06-19 02:21:41');

-- --------------------------------------------------------

--
-- Структура таблицы `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `action`, `description`, `created_at`) VALUES
(156, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-07 23:59:00'),
(157, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 00:01:00'),
(158, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:02:00'),
(159, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:03:00'),
(160, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 00:03:00'),
(161, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-08 00:03:00'),
(162, 23, 'Сброс пароля', 'Пользователь hr сбросил пароль', '2025-06-08 00:04:50'),
(163, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:04:00'),
(164, 26, 'Вход', 'Пользователь с ID 26 вошёл в систему', '2025-06-08 00:05:00'),
(165, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:06:00'),
(166, 26, 'Вход', 'Пользователь с ID 26 вошёл в систему', '2025-06-08 00:07:00'),
(167, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:07:00'),
(168, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 00:08:00'),
(169, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:08:00'),
(170, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 00:09:00'),
(171, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:09:00'),
(172, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 00:10:00'),
(173, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 11:10:00'),
(174, 23, 'Сброс пароля', 'Пользователь hr сбросил пароль', '2025-06-08 00:11:20'),
(175, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:11:00'),
(176, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 11:11:00'),
(177, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-08 11:05:00'),
(178, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:12:00'),
(179, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-08 00:13:00'),
(180, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 22:45:00'),
(181, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-10 22:45:00'),
(182, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 22:48:00'),
(183, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 22:58:00'),
(184, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-10 22:58:00'),
(185, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 23:00:00'),
(186, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 23:01:00'),
(187, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-10 23:15:00'),
(188, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:03:00'),
(189, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:04:00'),
(190, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:18:00'),
(191, 28, 'Вход', 'Пользователь с ID 28 вошёл в систему', '2025-06-15 22:27:00'),
(192, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:27:00'),
(193, 28, 'Вход', 'Пользователь с ID 28 вошёл в систему', '2025-06-15 22:28:00'),
(194, 28, 'Вход', 'Пользователь с ID 28 вошёл в систему', '2025-06-15 22:38:00'),
(195, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:39:00'),
(196, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:45:00'),
(197, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:46:00'),
(198, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:47:00'),
(199, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-15 22:48:00'),
(200, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-15 22:48:00'),
(201, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-15 22:49:00'),
(202, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:06:00'),
(203, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-19 01:12:00'),
(204, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 01:13:00'),
(205, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:13:00'),
(206, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:14:00'),
(207, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:16:00'),
(208, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:18:00'),
(209, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:24:00'),
(210, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:24:00'),
(211, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:27:00'),
(212, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:28:00'),
(213, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:29:00'),
(214, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:29:00'),
(215, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:30:00'),
(216, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:32:00'),
(217, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-19 01:34:00'),
(218, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:35:00'),
(219, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:36:00'),
(220, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-19 01:36:00'),
(221, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 01:36:00'),
(222, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:37:00'),
(223, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 01:38:00'),
(224, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-19 01:52:00'),
(225, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 01:53:00'),
(226, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-19 01:54:00'),
(227, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:03:00'),
(228, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:04:00'),
(229, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-19 02:05:00'),
(230, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:05:00'),
(231, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:21:00'),
(232, 24, 'Вход', 'Пользователь с ID 24 вошёл в систему', '2025-06-19 02:21:00'),
(233, 25, 'Вход', 'Пользователь с ID 25 вошёл в систему', '2025-06-19 02:22:00'),
(234, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:22:00'),
(235, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 02:24:00'),
(236, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 02:27:00'),
(237, 27, 'Вход', 'Пользователь с ID 27 вошёл в систему', '2025-06-19 02:39:00'),
(238, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:39:00'),
(239, 30, 'Вход', 'Пользователь с ID 30 вошёл в систему', '2025-06-19 02:41:00'),
(240, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:42:00'),
(241, 31, 'Вход', 'Пользователь с ID 31 вошёл в систему', '2025-06-19 02:43:00'),
(242, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:43:00'),
(243, 32, 'Вход', 'Пользователь с ID 32 вошёл в систему', '2025-06-19 02:44:00'),
(244, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:45:00'),
(245, 23, 'Вход', 'Пользователь с ID 23 вошёл в систему', '2025-06-19 02:53:00'),
(246, 31, 'Вход', 'Пользователь с ID 31 вошёл в систему', '2025-06-19 02:54:00'),
(247, 32, 'Вход', 'Пользователь с ID 32 вошёл в систему', '2025-06-19 02:54:00'),
(248, 31, 'Вход', 'Пользователь с ID 31 вошёл в систему', '2025-06-19 02:54:00'),
(249, 30, 'Вход', 'Пользователь с ID 30 вошёл в систему', '2025-06-19 02:54:00');

-- --------------------------------------------------------

--
-- Структура таблицы `motivation_actions`
--

CREATE TABLE `motivation_actions` (
  `id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `action_type` enum('bonus','training','promotion') NOT NULL,
  `reason` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `motivation_actions`
--

INSERT INTO `motivation_actions` (`id`, `employee_id`, `action_type`, `reason`, `created_by`, `created_at`) VALUES
(9, 21, 'training', 'Закрытие плана на май', NULL, '2025-06-19 01:33:53');

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Administrator'),
(2, 'Employee'),
(3, 'HR'),
(4, 'Candidat'),
(5, 'Uvolenni');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `login` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password_hash`, `role`, `created_at`) VALUES
(23, 'hr', '1b52f3a2e15148731314bf167145c54565ed2385a862b5eb7771eaf719e4f82e', 3, '2025-06-07 23:59:16'),
(24, 'emp', '9d586dc0a48a2ed04839e0a69750893438e8d379e2fa45e94e82c5b3abb00daa', 5, '2025-06-08 00:00:58'),
(25, 'adm', '86f65e28a754e1a71b2df9403615a6c436c32c42a75a10d02813961b86f1e428', 1, '2025-06-08 00:02:25'),
(26, 'fire', 'dc9f28b12dd1818ee42ffc92ecb940386214598837348d30d3c6c0b7b57e34c9', 5, '2025-06-08 00:05:36'),
(27, 'test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', 2, '2025-06-10 22:45:50'),
(28, 't1', '628b49d96dcde97a430dd4f597705899e09a968f793491e4b704cae33a40dc02', 2, '2025-06-15 22:27:27'),
(29, 'qqq', 'a95bc16631ae2b6fadb455ee018da0adc2703e56d89e3eed074ce56d2f7b1b6a', 4, '2025-06-19 02:22:48'),
(30, 'test1', '1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014', 2, '2025-06-19 02:41:55'),
(31, 'test2', '60303ae22b998861bce3b28f33eec1be758a213c86c93c076dbe9f558c11c752', 5, '2025-06-19 02:43:11'),
(32, 'test3', 'fd61a03af4f77d870fc21e05e7e80678095c92d808cfb3b5c279ee04c74aca13', 4, '2025-06-19 02:44:43');

-- --------------------------------------------------------

--
-- Структура таблицы `vacancies`
--

CREATE TABLE `vacancies` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `employment_type` enum('ТК','ГПХ','Самозанятый') NOT NULL,
  `required_experience` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `vacancies`
--

INSERT INTO `vacancies` (`id`, `title`, `city`, `salary`, `employment_type`, `required_experience`, `is_active`) VALUES
(7, 'Инженер', 'Москва', '120000.00', 'ТК', 5, 1),
(8, 'Прораб', 'Москва', '90000.00', 'ГПХ', 0, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vacancy_id` (`vacancy_id`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Индексы таблицы `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индексы таблицы `firings`
--
ALTER TABLE `firings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `fired_by` (`fired_by`);

--
-- Индексы таблицы `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Индексы таблицы `motivation_actions`
--
ALTER TABLE `motivation_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`login`),
  ADD KEY `role` (`role`);

--
-- Индексы таблицы `vacancies`
--
ALTER TABLE `vacancies`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `firings`
--
ALTER TABLE `firings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT для таблицы `motivation_actions`
--
ALTER TABLE `motivation_actions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `vacancies`
--
ALTER TABLE `vacancies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`vacancy_id`) REFERENCES `vacancies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_employee_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `firings`
--
ALTER TABLE `firings`
  ADD CONSTRAINT `firings_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `firings_ibfk_2` FOREIGN KEY (`fired_by`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `motivation_actions`
--
ALTER TABLE `motivation_actions`
  ADD CONSTRAINT `motivation_actions_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `motivation_actions_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
