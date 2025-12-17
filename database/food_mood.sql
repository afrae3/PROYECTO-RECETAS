-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-12-2025 a las 11:31:21
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `food_mood`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alergeno`
--

CREATE TABLE `alergeno` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alergeno`
--

INSERT INTO `alergeno` (`id`, `nombre`) VALUES
(1, 'Gluten'),
(2, 'Lácteos'),
(3, 'Huevos'),
(4, 'Frutos secos'),
(5, 'Cacahuetes'),
(6, 'Soja'),
(7, 'Pescado'),
(8, 'Mariscos'),
(9, 'Apio'),
(10, 'Mostaza'),
(11, 'Sésamo'),
(12, 'Sulfitos'),
(13, 'Altramuces'),
(14, 'Moluscos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(1, 'Desayuno'),
(2, 'Keto / Low Carb'),
(3, 'Vegano'),
(4, 'Vegetariano'),
(5, 'Paleo'),
(6, 'Mediterránea'),
(7, 'Alto en Proteínas'),
(8, 'Bajo en Calorías'),
(9, 'Sin Gluten'),
(10, 'Diabético Friendly'),
(11, 'Anti-Inflamatorio'),
(12, 'Detox / Depurativo'),
(13, 'Pre-Entreno'),
(14, 'Post-Entreno'),
(15, 'Batch Cooking'),
(16, 'Snacks Saludables'),
(17, 'Comida Rápida Saludable'),
(18, 'Comidas Completas'),
(19, 'Postres Saludables'),
(20, 'Smoothies y Bebidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20251201200147', '2025-12-01 21:02:07', 1065),
('DoctrineMigrations\\Version20251207120000', '2025-12-07 19:51:17', 317),
('DoctrineMigrations\\Version20251212140000', '2025-12-12 14:53:21', 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favorito`
--

CREATE TABLE `favorito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `favorito`
--

INSERT INTO `favorito` (`id`, `usuario_id`, `receta_id`) VALUES
(4, 1, 3),
(5, 1, 7),
(6, 1, 6),
(7, 1, 18),
(8, 1, 79);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente`
--

CREATE TABLE `ingrediente` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `calorias` double NOT NULL,
  `proteinas` double NOT NULL,
  `grasas` double NOT NULL,
  `carbohidratos` double NOT NULL,
  `fibra` double NOT NULL,
  `azucares` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingrediente`
--

INSERT INTO `ingrediente` (`id`, `nombre`, `calorias`, `proteinas`, `grasas`, `carbohidratos`, `fibra`, `azucares`) VALUES
(1, 'Tomate', 18, 0.88, 0.2, 3.89, 1.2, 2.6),
(2, 'Cebolla', 40, 1, 0, 9, 1, 4.2),
(3, 'Ajo', 149, 6.36, 0.5, 33.06, 2.1, 1),
(4, 'Pimiento', 24, 0.91, 0.22, 5.13, 1.8, 2.8),
(5, 'Zanahoria', 41, 0.93, 0.24, 9.58, 2.8, 4.7),
(6, 'Lechuga', 14, 0.9, 0.14, 2.97, 1.2, 0.8),
(7, 'Espinaca', 23, 2.86, 0.39, 3.63, 2.2, 0.4),
(8, 'Brócoli', 34, 2.82, 0.37, 6.64, 2.6, 1.7),
(9, 'Coliflor', 25, 1.92, 0.28, 4.97, 2, 1.9),
(10, 'Berenjena', 25, 0.98, 0.18, 5.88, 3, 3.5),
(11, 'Calabacín', 14, 0.6, 0.2, 2.2, 0.5, 1.7),
(12, 'Pepino', 12, 0.59, 0.16, 2.16, 0.7, 1.4),
(13, 'Apio', 16, 0.69, 0.17, 2.97, 1.6, 1.8),
(14, 'Puerro', 61, 1.5, 0.3, 14.15, 1.8, 3.9),
(15, 'Acelga', 19, 1.8, 0.2, 3.74, 1.6, 1.1),
(16, 'Remolacha', 43, 1.61, 0.17, 9.56, 2.8, 6.8),
(17, 'Nabo', 28, 0.9, 0.1, 6.43, 1.8, 3.8),
(18, 'Champiñón', 22, 3.09, 0.34, 3.26, 1, 1.9),
(19, 'Calabaza', 20, 0.72, 0.07, 4.88, 1.1, 2.8),
(20, 'Espárrago', 20, 2.2, 0.12, 3.88, 2.1, 1.9),
(21, 'Manzana', 52, 0.26, 0.17, 13.81, 2.4, 10.4),
(22, 'Plátano', 89, 1.09, 0.33, 22.84, 2.6, 12.2),
(23, 'Naranja', 47, 0.94, 0.12, 11.75, 2.4, 9.4),
(24, 'Limón', 29, 1.1, 0.3, 9.32, 2.8, 2.5),
(25, 'Fresa', 32, 0.67, 0.3, 7.68, 2, 4.9),
(26, 'Kiwi', 61, 1.14, 0.52, 14.66, 3, 9),
(27, 'Piña', 50, 0.54, 0.12, 13.12, 1.4, 9.9),
(28, 'Sandía', 30, 0.61, 0.15, 7.55, 0.4, 6.2),
(29, 'Melón', 34, 0.84, 0.19, 8.16, 0.9, 7.9),
(30, 'Uva', 69, 0.72, 0.16, 18.1, 0.9, 15.5),
(31, 'Pera', 57, 0.36, 0.14, 15.23, 3.1, 9.8),
(32, 'Melocotón', 39, 0.91, 0.25, 9.54, 1.5, 8.4),
(33, 'Cereza', 50, 1, 0.3, 12.18, 1.6, 8.5),
(34, 'Aguacate', 160, 2, 14.66, 8.53, 6.7, 0.7),
(35, 'Mandarina', 53, 0.81, 0.31, 13.34, 1.8, 10.6),
(36, 'Mango', 60, 0.82, 0.38, 14.98, 1.6, 13.7),
(37, 'Papaya', 43, 0.47, 0.26, 10.82, 1.7, 7.8),
(38, 'Pollo (pechuga)', 175, 26.37, 7.67, 0.09, 0, 0),
(39, 'Ternera (magra)', 109, 21, 3, 0, 0, 0),
(40, 'Cerdo (lomo)', 142, 27.24, 2.8, 0, 0, 0),
(41, 'Cordero (magra)', 122, 20, 3, 0, 0, 0),
(42, 'Pavo', 107, 21.9, 2.2, 0, 0, 0),
(43, 'Jamón cocido', 114, 21, 3, 0.4, 0, 0),
(44, 'Jamón serrano', 241, 31, 13, 0, 0, 0),
(45, 'Salmón', 127, 20.5, 4.4, 0, 0, 0),
(46, 'Atún fresco', 109, 24.4, 0.49, 0, 0, 0),
(47, 'Merluza', 89, 15.9, 2.8, 0, 0, 0),
(48, 'Bacalao', 76, 17, 1, 0, 0, 0),
(49, 'Dorada', 140, 20.82, 6.34, 0, 0, 0),
(50, 'Lubina', 122, 23.18, 2.52, 0, 0, 0),
(51, 'Gamba', 96, 19.8, 1.7, 0, 0, 0),
(52, 'Calamar', 92, 15.58, 1.38, 3.08, 0, 0),
(53, 'Mejillón', 86, 11.9, 2.24, 3.69, 0, 0),
(54, 'Pulpo', 69, 13.4, 1, 1.4, 0, 0),
(55, 'Lentejas (cocidas)', 115, 8.98, 0.38, 20.03, 7.9, 1.8),
(56, 'Garbanzos (cocidos)', 163, 8.81, 2.57, 27.25, 7.6, 4.8),
(57, 'Judías blancas (cocidas)', 138, 9.68, 0.35, 24.95, 6.3, 0.3),
(58, 'Lentejas rojas (cocidas)', 116, 7.6, 0.4, 20.1, 7.9, 1.8),
(59, 'Alubias negras (cocidas)', 132, 8.86, 0.54, 23.71, 8.7, 0.3),
(60, 'Habas (cocidas)', 110, 7.6, 0.4, 19.65, 5.4, 1.8),
(61, 'Guisantes (cocidos)', 126, 5.76, 3.47, 18.8, 4, 5.7),
(62, 'Guisantes frescos', 81, 5.42, 0.4, 14.45, 5.7, 5.7),
(63, 'Arroz blanco (cocido)', 129, 2.67, 0.28, 27.99, 0.4, 0.1),
(64, 'Pasta (cocida)', 157, 5.76, 0.92, 30.68, 1.8, 0.6),
(65, 'Pan blanco', 266, 8.85, 3.33, 49.42, 2.7, 5),
(66, 'Pan integral', 252, 12.45, 3.5, 42.71, 6, 3.5),
(67, 'Avena', 379, 13.15, 6.52, 67.7, 10.1, 0.9),
(68, 'Quinoa (cocida)', 120, 4.4, 1.92, 21.3, 2.8, 0.9),
(69, 'Leche entera', 61, 3.15, 3.25, 4.8, 0, 5.1),
(70, 'Leche semidesnatada', 49, 3.5, 1.8, 5, 0, 5.1),
(71, 'Yogur natural', 61, 3.47, 3.25, 4.66, 0, 4.7),
(72, 'Yogur griego', 97, 9, 5, 4, 0, 4),
(73, 'Queso manchego', 390, 29, 29, 0, 0, 0),
(74, 'Queso fresco', 175, 15, 11, 4, 0, 3.5),
(75, 'Queso mozzarella', 300, 22.17, 22.35, 2.19, 0, 1),
(76, 'Queso parmesano', 420, 28.42, 27.84, 13.91, 0, 0.9),
(77, 'Huevo entero', 143, 12.56, 9.51, 0.72, 0, 0.4),
(78, 'Clara de huevo', 52, 10.9, 0.17, 0.73, 0, 0.7),
(79, 'Yema de huevo', 322, 15.86, 26.54, 3.59, 0, 0.6),
(80, 'Mantequilla', 717, 0.85, 81.11, 0.06, 0, 0.06),
(81, 'Nata líquida', 331, 2, 31, 10, 0, 3.3),
(82, 'Almendra', 610, 18.7, 54, 5.3, 9.7, 4.4),
(83, 'Nuez', 654, 15.23, 65.21, 13.71, 6.7, 2.6),
(84, 'Avellana', 628, 14.95, 60.75, 16.7, 9.7, 4.3),
(85, 'Pistacho', 572, 21.05, 45.82, 28.28, 10.3, 7.7),
(86, 'Cacahuete', 567, 25.8, 49.24, 16.13, 8.5, 4.7),
(87, 'Piñón', 673, 13.69, 68.37, 13.08, 3.7, 3.6),
(88, 'Anacardo', 609, 12.12, 53.03, 30.3, 3, 5.9),
(89, 'Semillas de chía', 534, 18.29, 42.16, 28.88, 27.3, 0),
(90, 'Almendra laminada', 610, 18.7, 54, 5.3, 9.7, 4.4),
(91, 'Nuez picada', 654, 15.23, 65.21, 13.71, 6.7, 2.6),
(92, 'Avellana tostada', 628, 14.95, 60.75, 16.7, 9.7, 4.3),
(93, 'Cacahuete tostado', 567, 25.8, 49.24, 16.13, 8.5, 4.7),
(94, 'Piñón tostado', 673, 13.69, 68.37, 13.08, 3.7, 3.6),
(95, 'Anacardo tostado', 609, 12.12, 53.03, 30.3, 3, 5.9),
(96, 'Semillas de lino', 534, 18.29, 42.16, 28.88, 27.3, 1.6),
(97, 'Semillas de sésamo', 567, 16.96, 48, 26.04, 16.9, 0.3),
(98, 'Semillas de girasol', 582, 19.33, 49.8, 24.07, 11.1, 2.6),
(99, 'Tahini', 595, 17, 54, 21, 9.3, 0.5),
(100, 'Aceite de oliva', 884, 0, 100, 0, 0, 0),
(101, 'Aceite de girasol', 884, 0, 100, 0, 0, 0),
(102, 'Aceite de coco', 892, 0, 99.06, 0, 0, 0),
(103, 'Sal', 0, 0, 0, 0, 0, 0),
(104, 'Pimienta negra', 251, 10.39, 3.26, 63.95, 25.3, 0.6),
(105, 'Pimentón dulce', 282, 14.14, 12.89, 53.99, 34.9, 10.3),
(106, 'Comino', 375, 17.81, 22.27, 44.24, 10.5, 2.2),
(107, 'Sal marina', 0, 0, 0, 0, 0, 0),
(108, 'Pimienta blanca', 251, 10.39, 3.26, 63.95, 25.3, 0.6),
(109, 'Comino molido', 375, 17.81, 22.27, 44.24, 10.5, 2.2),
(110, 'Pimentón picante', 282, 14.14, 12.89, 53.99, 34.9, 10.3),
(111, 'Orégano seco', 265, 9, 4.28, 68.92, 42.5, 4.1),
(112, 'Aceite de oliva virgen extra', 884, 0, 100, 0, 0, 0),
(113, 'Aceite vegetal', 884, 0, 100, 0, 0, 0),
(114, 'Manteca', 900, 0, 100, 0, 0, 0),
(115, 'Albahaca fresca', 23, 3.15, 0.64, 2.65, 1.6, 0.3),
(116, 'Perejil fresco', 36, 2.97, 0.79, 6.33, 3.3, 0.9),
(117, 'Cilantro fresco', 23, 2.13, 0.52, 3.67, 2.8, 0.9),
(118, 'Jengibre fresco', 80, 1.82, 0.75, 17.77, 2, 1.7),
(119, 'Canela molida', 247, 3.99, 1.24, 80.59, 53.1, 2.2),
(120, 'Azúcar blanco', 387, 0, 0, 99.98, 0, 99.9),
(121, 'Azúcar', 387, 0, 0, 99.98, 0, 99.9),
(122, 'Miel', 304, 0.3, 0, 82.4, 0.2, 82.1),
(123, 'Vinagre de vino', 21, 0, 0, 0.93, 0, 0.4),
(124, 'Vinagre', 21, 0, 0, 0.93, 0, 0.4),
(125, 'Salsa de soja', 53, 8.14, 0.57, 4.93, 0.8, 0.8),
(126, 'Mostaza', 60, 3.74, 3.34, 5.83, 4, 0.3),
(127, 'Tomate frito', 88, 1.5, 6.4, 5.2, 1.6, 3.8),
(128, 'Caldo de pollo', 6, 0.64, 0.21, 0.44, 0, 0.2),
(129, 'Caldo de verduras', 5, 0.24, 0.07, 0.93, 0, 0.3),
(130, 'Levadura fresca', 105, 12, 1.4, 14, 7, 0),
(131, 'Chocolate negro (70%)', 528, 4.5, 33.2, 60.18, 6.4, 48),
(132, 'Batata', 86, 1.6, 0.1, 20.1, 3, 4.2),
(133, 'Patata', 77, 2, 0.1, 17, 2.1, 0.8),
(134, 'Repollo', 25, 1.28, 0.1, 5.8, 2.5, 3.2),
(135, 'Maíz', 86, 3.27, 1.35, 18.7, 2, 6.3),
(136, 'Dátiles', 282, 2.5, 0.4, 75, 8, 63.4),
(137, 'Frambuesa', 52, 1.2, 0.65, 11.9, 6.5, 4.4),
(138, 'Leche de coco', 230, 2.3, 23.8, 6, 2.2, 3.3),
(139, 'Cacao en polvo', 228, 19.6, 13.7, 57.9, 33, 1.8),
(140, 'Azafrán', 310, 11.4, 5.9, 65.4, 3.9, 0),
(141, 'Romero', 131, 3.3, 5.9, 20.7, 14.1, 0),
(142, 'Cúrcuma', 312, 9.7, 3.2, 67.1, 22.7, 3.2),
(143, 'Té verde', 1, 0, 0, 0, 0, 0),
(144, 'Menta fresca', 70, 3.8, 0.9, 14.9, 8, 0),
(145, 'Bechamel', 150, 4, 10, 11, 0.5, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instruccion`
--

CREATE TABLE `instruccion` (
  `id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL,
  `paso` longtext NOT NULL,
  `orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `instruccion`
--

INSERT INTO `instruccion` (`id`, `receta_id`, `paso`, `orden`) VALUES
(6, 2, 'Tostar las rebanadas de pan integral hasta que estén doradas y crujientes', 1),
(7, 2, 'Cortar el aguacate por la mitad, retirar el hueso y extraer la pulpa con una cuchara', 2),
(8, 2, 'Machacar el aguacate con un tenedor hasta obtener una pasta', 3),
(9, 2, 'Hervir agua en una olla pequeña. Cuando hierva, crear un remolino y agregar los huevos para pocharlos durante 3-4 minutos', 4),
(10, 2, 'Untar el aguacate machacado sobre las tostadas', 5),
(11, 2, 'Colocar el huevo pochado encima, sazonar con sal y servir', 6),
(12, 3, 'Congelar el plátano cortado en rodajas durante al menos 2 horas', 1),
(13, 3, 'En una batidora potente, añadir las espinacas, el plátano congelado, el mango y la leche', 2),
(14, 3, 'Triturar a máxima potencia hasta obtener una mezcla cremosa y espesa', 3),
(15, 3, 'Verter en un bol y decorar con frutas frescas, semillas o frutos secos al gusto', 4),
(16, 4, 'Separar las claras de las yemas de huevo', 1),
(17, 4, 'Batir ligeramente las claras con una pizca de sal', 2),
(18, 4, 'Calentar una sartén antiadherente con un poco de aceite a fuego medio', 3),
(19, 4, 'Verter las claras batidas y añadir las espinacas frescas picadas por encima', 4),
(20, 4, 'Cocinar hasta que la tortilla esté cuajada, doblar por la mitad y servir', 5),
(32, 7, 'Cocinar las gambas a la plancha con un poco de aceite durante 2-3 minutos', 1),
(33, 7, 'Cortar el aguacate en láminas', 2),
(34, 7, 'Lavar y cortar la lechuga', 3),
(35, 7, 'En un bol, mezclar la lechuga, el aguacate y las gambas', 4),
(36, 7, 'Aliñar con aceite de oliva, jugo de limón y sal al gusto', 5),
(37, 8, 'Precalentar el horno a 180°C', 1),
(38, 8, 'Cortar los calabacines por la mitad a lo largo y vaciar el interior con una cuchara', 2),
(39, 8, 'Picar la pulpa del calabacín y mezclarla con la carne picada, tomate, cebolla y ajo', 3),
(40, 8, 'Rellenar los calabacines con la mezcla de carne', 4),
(41, 8, 'Hornear durante 30-35 minutos hasta que estén tiernos', 5),
(42, 8, 'Servir caliente', 6),
(43, 9, 'Cocinar la quinoa según las instrucciones del paquete y dejar enfriar', 1),
(44, 9, 'Escurrir y enjuagar los garbanzos', 2),
(45, 9, 'Cortar el pimiento en dados pequeños', 3),
(46, 9, 'En un bol, mezclar la quinoa, los garbanzos y el pimiento', 4),
(47, 9, 'Aliñar con aceite de oliva, sal y especias al gusto', 5),
(48, 9, 'Servir frío o a temperatura ambiente', 6),
(49, 10, 'En una olla, sofreír la cebolla y el ajo picados en aceite hasta que estén dorados', 1),
(50, 10, 'Añadir las lentejas rojas escurridas y remover', 2),
(51, 10, 'Incorporar la leche de coco, la cúrcuma y especias al gusto', 3),
(52, 10, 'Cocinar a fuego medio durante 20-25 minutos hasta que las lentejas estén tiernas', 4),
(53, 10, 'Servir caliente acompañado de arroz si se desea', 5),
(54, 11, 'Escurrir y enjuagar las alubias negras', 1),
(55, 11, 'En un procesador, triturar las alubias con cebolla, ajo y avena hasta formar una masa', 2),
(56, 11, 'Sazonar con sal, pimienta y comino', 3),
(57, 11, 'Formar hamburguesas con las manos', 4),
(58, 11, 'Cocinar en una sartén con aceite 4-5 minutos por cada lado', 5),
(59, 11, 'Servir en pan integral o con ensalada', 6),
(60, 12, 'Lavar bien las espinacas y colocarlas en un bol grande', 1),
(61, 12, 'Pelar y cortar la naranja en gajos', 2),
(62, 12, 'Añadir las almendras laminadas', 3),
(63, 12, 'Preparar un aliño con aceite de oliva, jugo de naranja y sal', 4),
(64, 12, 'Mezclar todo y servir inmediatamente', 5),
(72, 14, 'Cocinar la pasta integral según las instrucciones del paquete', 1),
(73, 14, 'Mientras tanto, limpiar y laminar los champiñones', 2),
(74, 14, 'En una sartén, sofreír el ajo picado en aceite', 3),
(75, 14, 'Añadir los champiñones y saltear hasta que estén dorados', 4),
(76, 14, 'Escurrir la pasta y mezclarla con los champiñones', 5),
(77, 14, 'Espolvorear con perejil fresco picado y servir', 6),
(78, 15, 'Precalentar el horno a 180°C', 1),
(79, 15, 'Cortar las berenjenas en láminas finas a lo largo', 2),
(80, 15, 'Dorar ligeramente las láminas de berenjena en una sartén con aceite', 3),
(81, 15, 'Preparar un sofrito con la carne picada y el tomate frito', 4),
(82, 15, 'En una fuente de horno, ir alternando capas de berenjena, carne y bechamel', 5),
(83, 15, 'Terminar con bechamel y queso mozzarella por encima', 6),
(84, 15, 'Hornear durante 30-35 minutos hasta que esté gratinado', 7),
(85, 16, 'En una olla, sofreír la cebolla picada en aceite hasta que esté transparente', 1),
(86, 16, 'Añadir el arroz y tostar durante 2 minutos removiendo', 2),
(87, 16, 'Incorporar los espárragos cortados en trozos', 3),
(88, 16, 'Ir añadiendo caldo caliente poco a poco, removiendo constantemente', 4),
(89, 16, 'Cuando el arroz esté cremoso y al dente (unos 18-20 minutos), retirar del fuego', 5),
(90, 16, 'Añadir el queso parmesano rallado y mezclar bien', 6),
(91, 16, 'Servir inmediatamente', 7),
(92, 17, 'Cortar la ternera en tiras finas', 1),
(93, 17, 'Lavar y cortar los pimientos en tiras', 2),
(94, 17, 'Picar la cebolla', 3),
(95, 17, 'En un wok o sartén grande, calentar aceite a fuego alto', 4),
(96, 17, 'Saltear la ternera hasta que esté dorada, retirar y reservar', 5),
(97, 17, 'En la misma sartén, saltear los pimientos y la cebolla', 6),
(98, 17, 'Incorporar la carne, añadir salsa de soja y mezclar bien', 7),
(99, 17, 'Servir caliente', 8),
(100, 18, 'Precalentar el horno a 200°C', 1),
(101, 18, 'Pelar y cortar el boniato en trozos medianos', 2),
(102, 18, 'Sazonar el pollo con sal, pimienta y romero', 3),
(103, 18, 'Colocar el pollo y el boniato en una bandeja de horno', 4),
(104, 18, 'Rociar con aceite de oliva', 5),
(105, 18, 'Hornear durante 40-45 minutos hasta que todo esté bien cocido', 6),
(106, 18, 'Servir caliente', 7),
(107, 19, 'Cocinar el atún a la plancha 2-3 minutos por cada lado', 1),
(108, 19, 'Lavar y cortar la lechuga, el tomate y el pepino', 2),
(109, 19, 'Mezclar todas las verduras en un bol', 3),
(110, 19, 'Cortar el atún en láminas y colocarlo sobre la ensalada', 4),
(111, 19, 'Aliñar con aceite de oliva, sal y limón', 5),
(119, 21, 'Lavar y cortar en dados el tomate, pepino y pimiento', 1),
(120, 21, 'Picar la cebolla finamente', 2),
(121, 21, 'Mezclar todas las verduras en un bol grande', 3),
(122, 21, 'Aliñar con aceite de oliva, sal y orégano', 4),
(123, 21, 'Servir frío', 5),
(130, 23, 'Lavar y cortar en trozos el tomate, pepino y pimiento', 1),
(131, 23, 'Pelar el ajo', 2),
(132, 23, 'Triturar todas las verduras con aceite y vinagre', 3),
(133, 23, 'Añadir agua fría hasta conseguir la textura deseada', 4),
(134, 23, 'Sazonar con sal y refrigerar al menos 2 horas', 5),
(135, 23, 'Servir bien frío', 6),
(136, 24, 'Limpiar los calamares y cortarlos en anillas', 1),
(137, 24, 'Calentar una plancha o sartén a fuego alto con aceite', 2),
(138, 24, 'Cocinar los calamares 2-3 minutos por cada lado', 3),
(139, 24, 'Añadir ajo picado y perejil', 4),
(140, 24, 'Servir inmediatamente', 5),
(141, 25, 'Cocinar las judías blancas si no están cocidas previamente', 1),
(142, 25, 'Cocinar la pechuga de pavo a la plancha con sal', 2),
(143, 25, 'En una sartén, sofreír las judías con tomate picado y aceite', 3),
(144, 25, 'Cortar el pavo en lonchas', 4),
(145, 25, 'Servir el pavo con las judías como guarnición', 5),
(146, 26, 'Cocinar la quinoa según las instrucciones del paquete', 1),
(147, 26, 'Cocinar el brócoli al vapor durante 5 minutos', 2),
(148, 26, 'Sellar el atún a la plancha 2 minutos por cada lado', 3),
(149, 26, 'Servir el atún sobre un lecho de quinoa acompañado del brócoli', 4),
(150, 26, 'Rociar con aceite de oliva', 5),
(151, 27, 'Separar las claras de las yemas', 1),
(152, 27, 'Batir las claras con una pizca de sal', 2),
(153, 27, 'Calentar una sartén con aceite', 3),
(154, 27, 'Verter las claras y añadir el jamón cocido cortado en tiras', 4),
(155, 27, 'Cocinar hasta que cuaje y servir doblada', 5),
(156, 28, 'Cocinar las lentejas si no están cocidas previamente', 1),
(157, 28, 'Hervir el huevo durante 10 minutos, enfriar y pelar', 2),
(158, 28, 'En un bol, colocar las lentejas como base', 3),
(159, 28, 'Añadir las espinacas frescas lavadas', 4),
(160, 28, 'Cortar el huevo por la mitad y colocarlo encima', 5),
(161, 28, 'Espolvorear con semillas de sésamo y servir', 6),
(162, 29, 'Cocinar la merluza al vapor durante 8-10 minutos', 1),
(163, 29, 'Mientras tanto, cocinar al vapor el calabacín, la zanahoria y el brócoli', 2),
(164, 29, 'Servir la merluza con las verduras al lado', 3),
(165, 29, 'Rociar con un chorrito de limón si se desea', 4),
(166, 30, 'Lavar y cortar la lechuga en trozos', 1),
(167, 30, 'Cortar el pepino y el tomate en rodajas', 2),
(168, 30, 'Mezclar todo en un bol', 3),
(169, 30, 'Preparar un aliño con aceite de oliva, limón y sal', 4),
(170, 30, 'Servir fresco', 5),
(171, 31, 'Precalentar el horno a 200°C', 1),
(172, 31, 'Cortar la calabaza en rodajas de 1 cm de grosor', 2),
(173, 31, 'Colocar en una bandeja, rociar con aceite y hornear 25 minutos', 3),
(174, 31, 'Mientras tanto, saltear las espinacas con ajo picado', 4),
(175, 31, 'Servir la calabaza asada con las espinacas por encima', 5),
(176, 32, 'Lavar y cortar en trozos el apio, puerro, zanahoria y calabacín', 1),
(177, 32, 'En una olla, calentar el caldo de verduras', 2),
(178, 32, 'Añadir todas las verduras y cocinar a fuego medio 25-30 minutos', 3),
(179, 32, 'Triturar si se desea una sopa crema', 4),
(180, 32, 'Servir caliente', 5),
(181, 33, 'Cocinar el arroz blanco según las instrucciones', 1),
(182, 33, 'Cortar el pollo en trozos y sazonar', 2),
(183, 33, 'En una paella o sartén grande, sofreír el pollo', 3),
(184, 33, 'Añadir el pimiento y los guisantes', 4),
(185, 33, 'Incorporar el arroz cocido y mezclar bien', 5),
(186, 33, 'Rociar con aceite y servir caliente', 6),
(187, 34, 'Desalar el bacalao durante 24 horas cambiando el agua varias veces', 1),
(188, 34, 'Pelar y cortar las patatas en rodajas', 2),
(189, 34, 'Colocar las patatas y la cebolla en una bandeja de horno', 3),
(190, 34, 'Colocar el bacalao encima', 4),
(191, 34, 'Rociar con aceite y hornear a 180°C durante 35-40 minutos', 5),
(192, 35, 'Cocinar la quinoa según las instrucciones del paquete y dejar enfriar', 1),
(193, 35, 'Cortar el aguacate y el tomate en dados', 2),
(194, 35, 'Mezclar la quinoa con el aguacate y el tomate', 3),
(195, 35, 'Aliñar con aceite, limón y sal', 4),
(196, 35, 'Servir frío o a temperatura ambiente', 5),
(197, 36, 'Cortar el pollo en trozos y sazonar', 1),
(198, 36, 'En una olla, sofreír la cebolla picada', 2),
(199, 36, 'Añadir el pollo y dorar', 3),
(200, 36, 'Incorporar la cúrcuma y la leche de coco', 4),
(201, 36, 'Cocinar a fuego medio 20 minutos', 5),
(202, 36, 'Servir con arroz blanco cocido', 6),
(203, 37, 'En una sartén, calentar aceite y sofreír el ajo picado', 1),
(204, 37, 'Añadir los garbanzos escurridos', 2),
(205, 37, 'Incorporar las espinacas frescas y remover hasta que se ablanden', 3),
(206, 37, 'Sazonar con sal y servir caliente', 4),
(207, 38, 'Cocinar la coliflor al vapor hasta que esté tierna', 1),
(208, 38, 'Triturar la coliflor hasta formar un puré suave', 2),
(209, 38, 'Cocinar la pechuga de pollo a la plancha con sal', 3),
(210, 38, 'Servir el pollo con el puré de coliflor', 4),
(211, 39, 'En una olla, sofreír la zanahoria, cebolla y pimiento picados', 1),
(212, 39, 'Añadir las lentejas cocidas', 2),
(213, 39, 'Cubrir con caldo o agua y cocinar a fuego medio 30-35 minutos', 3),
(214, 39, 'Sazonar con sal y servir caliente', 4),
(215, 40, 'Escurrir las alubias negras', 1),
(216, 40, 'Cortar el tomate, pimiento y cebolla en dados pequeños', 2),
(217, 40, 'Mezclar todo en un bol', 3),
(218, 40, 'Añadir cilantro fresco picado', 4),
(219, 40, 'Aliñar con limón, aceite y sal', 5),
(220, 41, 'Marinar el salmón con jengibre rallado durante 15 minutos', 1),
(221, 41, 'Calentar una sartén con aceite', 2),
(222, 41, 'Cocinar el salmón 4 minutos por cada lado', 3),
(223, 41, 'Cocinar los espárragos en la misma sartén', 4),
(224, 41, 'Servir juntos', 5),
(225, 42, 'Escurrir los garbanzos', 1),
(226, 42, 'Mezclarlos con cúrcuma y aceite', 2),
(227, 42, 'Hornear a 200°C durante 20 minutos hasta que estén crujientes', 3),
(228, 42, 'Servir sobre espinacas frescas', 4),
(229, 43, 'Hornear la remolacha envuelta en papel de aluminio a 200°C durante 45 minutos', 1),
(230, 43, 'Dejar enfriar, pelar y cortar en dados', 2),
(231, 43, 'Mezclar con espinacas frescas y nueces', 3),
(232, 43, 'Aliñar con aceite de oliva y sal', 4),
(233, 44, 'Calentar agua hasta casi hervir', 1),
(234, 44, 'Añadir el té verde y dejar infusionar 3 minutos', 2),
(235, 44, 'Añadir rodajas de jengibre fresco y limón', 3),
(236, 44, 'Servir caliente', 4),
(237, 45, 'Lavar todas las verduras y la manzana', 1),
(238, 45, 'Cortarlas en trozos', 2),
(239, 45, 'Triturar todo en una licuadora con un poco de agua', 3),
(240, 45, 'Colar si se desea', 4),
(241, 45, 'Servir inmediatamente', 5),
(242, 46, 'Lavar y cortar la lechuga, pepino y apio', 1),
(243, 46, 'Mezclar en un bol', 2),
(244, 46, 'Exprimir el limón por encima', 3),
(245, 46, 'Añadir un chorrito de aceite y sal', 4),
(246, 46, 'Servir fresco', 5),
(247, 47, 'Lavar y cortar el puerro, apio y calabacín', 1),
(248, 47, 'En una olla, calentar el caldo de verduras', 2),
(249, 47, 'Añadir las verduras y cocinar 25 minutos', 3),
(250, 47, 'Triturar hasta obtener una crema suave', 4),
(251, 47, 'Servir caliente', 5),
(252, 48, 'Cortar el pepino en rodajas finas', 1),
(253, 48, 'Cortar el limón en rodajas', 2),
(254, 48, 'Colocar todo en una jarra con agua fría', 3),
(255, 48, 'Añadir hojas de menta fresca', 4),
(256, 48, 'Refrigerar 2 horas antes de servir', 5),
(257, 49, 'Tostar el pan integral', 1),
(258, 49, 'Cortar el plátano en rodajas', 2),
(259, 49, 'Colocar las rodajas sobre el pan', 3),
(260, 49, 'Espolvorear con canela', 4),
(261, 49, 'Servir inmediatamente', 5),
(262, 50, 'En una batidora, añadir la avena, la manzana pelada y cortada, y la leche', 1),
(263, 50, 'Añadir la canela', 2),
(264, 50, 'Triturar hasta obtener una mezcla homogénea', 3),
(265, 50, 'Servir frío', 4),
(266, 51, 'Cocinar el arroz blanco según las instrucciones', 1),
(267, 51, 'Cocinar el pavo a la plancha cortado en tiras', 2),
(268, 51, 'Cocinar el brócoli al vapor', 3),
(269, 51, 'Servir todo en un bol', 4),
(270, 52, 'Pelar y cortar el plátano', 1),
(271, 52, 'Deshuesar los dátiles', 2),
(272, 52, 'Triturar todo con la avena y la leche', 3),
(273, 52, 'Servir frío', 4),
(274, 53, 'Cocinar el arroz integral según las instrucciones', 1),
(275, 53, 'Cortar la pechuga de pollo en tiras y cocinar a la plancha', 2),
(276, 53, 'Rallar o picar la zanahoria finamente', 3),
(277, 53, 'Mezclar el pollo con el arroz y la zanahoria', 4),
(278, 53, 'Rociar con aceite y servir', 5),
(279, 54, 'En una batidora, mezclar el yogur griego, el plátano, las fresas y las almendras', 1),
(280, 54, 'Triturar hasta obtener una textura cremosa', 2),
(281, 54, 'Servir frío', 3),
(282, 55, 'Batir los huevos en un bol con sal', 1),
(283, 55, 'Calentar una sartén con aceite', 2),
(284, 55, 'Verter los huevos y cocinar hasta que cuajen', 3),
(285, 55, 'Servir con aguacate en láminas y tomate fresco', 4),
(286, 56, 'Cocinar la quinoa según las instrucciones', 1),
(287, 56, 'Cocinar el salmón a la plancha 4 minutos por lado', 2),
(288, 56, 'Saltear las espinacas con un poco de aceite', 3),
(289, 56, 'Servir el salmón sobre la quinoa con las espinacas al lado', 4),
(290, 57, 'Precalentar el horno a 180°C', 1),
(291, 57, 'Sazonar el pollo con sal, pimienta y hierbas', 2),
(292, 57, 'Pelar y cortar las verduras en trozos grandes', 3),
(293, 57, 'Colocar el pollo y las verduras en una bandeja', 4),
(294, 57, 'Rociar con aceite y hornear 90 minutos', 5),
(295, 58, 'Cocinar las lentejas y el arroz por separado', 1),
(296, 58, 'En una olla, sofreír la zanahoria y cebolla picadas', 2),
(297, 58, 'Añadir las lentejas y el arroz', 3),
(298, 58, 'Mezclar bien y cocinar 5 minutos más', 4),
(299, 58, 'Servir caliente', 5),
(300, 59, 'Cortar la ternera en dados grandes', 1),
(301, 59, 'En una olla, dorar la carne con aceite', 2),
(302, 59, 'Añadir la zanahoria, cebolla y tomate picados', 3),
(303, 59, 'Cubrir con agua o caldo y cocinar a fuego lento 2 horas', 4),
(304, 59, 'Servir caliente', 5),
(305, 60, 'Cocinar la pasta integral según las instrucciones', 1),
(306, 60, 'Cortar todas las verduras en dados', 2),
(307, 60, 'Saltear las verduras en aceite', 3),
(308, 60, 'Mezclar con la pasta escurrida', 4),
(309, 60, 'Servir caliente', 5),
(310, 61, 'Escurrir los garbanzos y guardar un poco del líquido', 1),
(311, 61, 'Triturar los garbanzos con tahini, ajo, limón y aceite', 2),
(312, 61, 'Añadir el líquido de los garbanzos para ajustar la textura', 3),
(313, 61, 'Sazonar con sal y comino', 4),
(314, 61, 'Servir con un chorrito de aceite y pimentón por encima', 5),
(315, 62, 'Pelar y cortar las zanahorias en bastones', 1),
(316, 62, 'Triturar el aguacate con limón y sal para hacer el guacamole', 2),
(317, 62, 'Servir los bastones de zanahoria con el guacamole para mojar', 3),
(318, 63, 'Precalentar el horno a 180°C', 1),
(319, 63, 'Extender las almendras en una bandeja', 2),
(320, 63, 'Tostar durante 10-15 minutos', 3),
(321, 63, 'Mezclar con pimentón y sal marina', 4),
(322, 63, 'Dejar enfriar y servir', 5),
(323, 64, 'Deshuesar los dátiles', 1),
(324, 64, 'Triturar los dátiles, nueces y cacao en un procesador', 2),
(325, 64, 'Formar bolitas con las manos', 3),
(326, 64, 'Refrigerar 30 minutos antes de servir', 4),
(327, 65, 'Cocinar el pollo a la plancha y cortarlo en tiras', 1),
(328, 65, 'Lavar y cortar la lechuga y el tomate', 2),
(329, 65, 'Calentar la tortilla de pan integral', 3),
(330, 65, 'Rellenar con el pollo, lechuga, tomate y yogur', 4),
(331, 65, 'Enrollar y servir', 5),
(332, 66, 'Lavar y cortar la lechuga romana', 1),
(333, 66, 'Cocinar el pollo a la plancha y cortarlo', 2),
(334, 66, 'Mezclar la lechuga con el pollo', 3),
(335, 66, 'Añadir queso parmesano rallado', 4),
(336, 66, 'Aliñar con aceite y servir', 5),
(337, 67, 'Cocinar el arroz blanco', 1),
(338, 67, 'Cocinar el atún a la plancha', 2),
(339, 67, 'En un bol, colocar el arroz como base', 3),
(340, 67, 'Añadir el atún en trozos, aguacate, tomate y maíz', 4),
(341, 67, 'Servir frío o tibio', 5),
(342, 68, 'Tostar ligeramente el pan integral', 1),
(343, 68, 'Colocar lonchas de pavo', 2),
(344, 68, 'Añadir aguacate en láminas, lechuga y tomate', 3),
(345, 68, 'Cerrar el bocadillo y servir', 4),
(346, 69, 'Cocinar el arroz en caldo de pollo con azafrán', 1),
(347, 69, 'Cortar el pollo en trozos y dorar en una paella', 2),
(348, 69, 'Añadir el pimiento cortado', 3),
(349, 69, 'Incorporar el arroz y los guisantes', 4),
(350, 69, 'Cocinar a fuego medio hasta que el arroz esté en su punto', 5),
(351, 69, 'Dejar reposar 5 minutos y servir', 6),
(352, 70, 'Precalentar el horno a 180°C', 1),
(353, 70, 'Sazonar el cordero con sal, ajo picado y romero', 2),
(354, 70, 'Pelar y cortar las patatas en gajos', 3),
(355, 70, 'Colocar el cordero y las patatas en una bandeja', 4),
(356, 70, 'Rociar con aceite y hornear 90 minutos', 5),
(357, 70, 'Servir caliente', 6),
(358, 71, 'Poner los garbanzos en remojo la noche anterior', 1),
(359, 71, 'En una olla grande, cocinar los garbanzos con agua durante 1 hora', 2),
(360, 71, 'Añadir la carne de ternera, zanahoria, puerro y repollo', 3),
(361, 71, 'Cocinar todo junto a fuego lento durante 2 horas', 4),
(362, 71, 'Servir el caldo primero y luego los garbanzos con la carne y verduras', 5),
(363, 72, 'Cocinar la carne picada con tomate frito', 1),
(364, 72, 'Cocinar la pasta según las instrucciones', 2),
(365, 72, 'En una fuente de horno, alternar capas de pasta, carne y bechamel', 3),
(366, 72, 'Terminar con bechamel y queso mozzarella', 4),
(367, 72, 'Hornear a 180°C durante 30 minutos', 5),
(368, 72, 'Dejar reposar antes de servir', 6),
(369, 73, 'En un bol, servir el yogur natural', 1),
(370, 73, 'Añadir las fresas y frambuesas lavadas', 2),
(371, 73, 'Espolvorear con nueces picadas', 3),
(372, 73, 'Servir frío', 4),
(373, 74, 'Precalentar el horno a 180°C', 1),
(374, 74, 'Lavar y quitar el corazón de las manzanas', 2),
(375, 74, 'Rellenar el hueco con canela y miel', 3),
(376, 74, 'Hornear durante 25-30 minutos', 4),
(377, 74, 'Servir tibio', 5),
(378, 75, 'Derretir el chocolate negro al baño maría', 1),
(379, 75, 'Triturar el aguacate hasta obtener un puré suave', 2),
(380, 75, 'Mezclar el chocolate con el aguacate y la miel', 3),
(381, 75, 'Refrigerar al menos 2 horas', 4),
(382, 75, 'Servir frío', 5),
(383, 76, 'Lavar y cortar la pera en rodajas', 1),
(384, 76, 'Colocar el queso fresco en un plato', 2),
(385, 76, 'Añadir las rodajas de pera encima', 3),
(386, 76, 'Espolvorear con nueces picadas', 4),
(387, 76, 'Servir inmediatamente', 5),
(388, 77, 'Pelar y cortar el mango, la piña y el plátano', 1),
(389, 77, 'Añadir todo a la batidora con la leche de coco', 2),
(390, 77, 'Triturar hasta obtener una mezcla suave', 3),
(391, 77, 'Servir frío', 4),
(392, 78, 'Lavar las espinacas', 1),
(393, 78, 'Pelar el plátano y cortar la manzana', 2),
(394, 78, 'Añadir todo a la batidora con jengibre rallado y leche', 3),
(395, 78, 'Triturar bien', 4),
(396, 78, 'Servir frío', 5),
(397, 79, 'Lavar las fresas y las cerezas', 1),
(398, 79, 'Deshuesarlas cerezas si es necesario', 2),
(399, 79, 'Triturar con el yogur y la miel', 3),
(400, 79, 'Servir frío', 4),
(401, 80, 'Exprimir los limones para obtener el jugo', 1),
(402, 80, 'Mezclar el jugo con agua fría en una jarra', 2),
(403, 80, 'Añadir la miel y remover hasta que se disuelva', 3),
(404, 80, 'Refrigerar hasta el momento de servir', 4),
(405, 80, 'Servir con hielo', 5),
(407, 1, 'En una cazuela, calentar la leche hasta que esté templada', 1),
(408, 1, 'Añadir la avena y cocinar a fuego medio, removiendo constantemente durante 5-7 minutos', 2),
(409, 1, 'Cuando la avena esté cremosa, retirar del fuego y dejar reposar 1 min', 3),
(410, 1, 'Servir en un bol y decorar con rodajas de plátano y fresas cortadas', 4),
(411, 1, 'Añadir un chorrito de miel por encima al gusto', 5),
(412, 5, 'Precalentar el horno a 200°C', 1),
(413, 5, 'Sazonar las pechugas de pollo con sal, pimienta y especias al gusto', 2),
(414, 5, 'Lavar el brócoli y cortarlo en ramilletes', 3),
(415, 5, 'Colocar el pollo y el brócoli en una bandeja de horno, rociar con aceite de oliva', 4),
(416, 5, 'Hornear durante 25-30 minutos hasta que el pollo esté bien cocido', 5),
(417, 5, 'Servir caliente', 6),
(418, 6, 'Sazonar los filetes de salmón con sal y pimienta', 1),
(419, 6, 'Calentar una plancha o sartén a fuego medio-alto con un poco de aceite', 2),
(420, 6, 'Cocinar el salmón 3-4 minutos por cada lado', 3),
(421, 6, 'Mientras tanto, cocinar los espárragos en la misma sartén durante 5 minutos', 4),
(422, 6, 'Servir el salmón con los espárragos y unas gotas de limón', 5),
(427, 13, 'Lavar y cortar los calabacines en rodajas finas', 1),
(428, 13, 'Picar la cebolla finamente', 2),
(429, 13, 'Batir los huevos en un bol grande con sal', 3),
(430, 13, 'En una sartén con aceite, sofreír el calabacín y la cebolla hasta que estén tiernos', 4),
(431, 13, 'Mezclar las verduras con los huevos batidos', 5),
(432, 13, 'Verter todo en la sartén y cocinar a fuego medio-bajo hasta que cuaje', 6),
(433, 13, 'Dar la vuelta a la tortilla y cocinar por el otro lado', 7),
(434, 22, 'Precalentar el horno a 200°C', 1),
(435, 22, 'Limpiar la dorada y hacerle unos cortes diagonales', 2),
(436, 22, 'Rellenar los cortes con rodajas de limón y ajo picado', 3),
(437, 22, 'Colocar en una bandeja de horno y rociar con aceite de oliva', 4),
(438, 22, 'Hornear durante 25-30 min', 5),
(439, 22, 'Servir caliente con más limón', 6),
(442, 20, 'Precalentar el horno a 180°C', 1),
(443, 20, 'Limpiar la lubina y hacerle unos cortes en la piel', 2),
(444, 20, 'Cortar el tomate y el calabacín en rodajas finas', 3),
(445, 20, 'Colocar la lubina sobre papel de horno, añadir las verduras alrededor', 4),
(446, 20, 'Rociar con aceite, añadir rodajas de limón y cerrar el papillote', 5),
(447, 20, 'Hornear durante 20-25 min', 6),
(448, 20, 'Abrir con cuidado y servir', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_receta`
--

CREATE TABLE `menu_receta` (
  `id` int(11) NOT NULL,
  `menu_semanal_id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL,
  `dia` varchar(50) NOT NULL,
  `tipo_comida` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `menu_receta`
--

INSERT INTO `menu_receta` (`id`, `menu_semanal_id`, `receta_id`, `dia`, `tipo_comida`) VALUES
(183, 10, 3, 'Martes', 'desayuno'),
(184, 10, 9, 'Martes', 'comida'),
(185, 10, 5, 'Martes', 'cena'),
(186, 10, 1, 'Miércoles', 'desayuno'),
(187, 10, 10, 'Miércoles', 'comida'),
(188, 10, 79, 'Miércoles', 'cena'),
(189, 10, 3, 'Jueves', 'desayuno'),
(190, 10, 12, 'Jueves', 'comida'),
(191, 10, 80, 'Jueves', 'cena'),
(192, 10, 2, 'Viernes', 'desayuno'),
(193, 10, 12, 'Viernes', 'comida'),
(194, 10, 6, 'Viernes', 'cena'),
(195, 10, 4, 'Sábado', 'desayuno'),
(196, 10, 12, 'Sábado', 'comida'),
(197, 10, 78, 'Sábado', 'cena'),
(198, 10, 3, 'Domingo', 'desayuno'),
(199, 10, 12, 'Domingo', 'comida'),
(200, 10, 79, 'Domingo', 'cena'),
(201, 10, 1, 'Lunes', 'desayuno'),
(202, 10, 11, 'Lunes', 'comida'),
(203, 10, 78, 'Lunes', 'cena');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_semanal`
--

CREATE TABLE `menu_semanal` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `menu_semanal`
--

INSERT INTO `menu_semanal` (`id`, `usuario_id`, `fecha_creacion`) VALUES
(10, 7, '2025-12-16 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_nutricionales`
--

CREATE TABLE `objetivos_nutricionales` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `calorias` int(11) NOT NULL DEFAULT 2000,
  `proteinas` decimal(6,1) NOT NULL DEFAULT 150.0,
  `grasas` decimal(6,1) NOT NULL DEFAULT 65.0,
  `carbohidratos` decimal(6,1) NOT NULL DEFAULT 250.0,
  `fibra` decimal(5,1) DEFAULT 25.0,
  `fecha_creacion` datetime NOT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `sexo` varchar(10) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `altura` int(11) DEFAULT NULL,
  `nivel_actividad` varchar(20) DEFAULT NULL,
  `objetivo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta`
--

CREATE TABLE `receta` (
  `id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` longtext DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `tiempo_preparacion` int(11) DEFAULT NULL,
  `porciones` int(11) DEFAULT NULL,
  `dificultad` varchar(50) DEFAULT NULL,
  `popularidad` int(11) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `receta`
--

INSERT INTO `receta` (`id`, `categoria_id`, `nombre`, `descripcion`, `imagen`, `tiempo_preparacion`, `porciones`, `dificultad`, `popularidad`, `fecha_creacion`) VALUES
(1, 1, 'Bowl de Avena con Frutas', 'Delicioso bowl de avena cocida con plátano, fresas y un toque de miel. Perfecto para empezar el día con energía.', 'bowl-fruta.jpg', 10, 1, 'Fácil', 95, '2025-12-01 21:27:08'),
(2, 1, 'Tostadas de Aguacate y Huevo', 'Pan integral tostado con aguacate machacado y huevo pochado. Rico en grasas saludables y proteínas.', 'tostada-huevo-aguacate.jpg', 15, 2, 'Fácil', 92, '2025-12-01 21:27:08'),
(3, 1, 'Smoothie Bowl Verde', 'Bowl cremoso de espinacas, plátano y mango, decorado con kiwi y semillas de chía.', 'smoothie-bowl-verde.jpg', 8, 1, 'Fácil', 88, '2025-12-01 21:27:08'),
(4, 1, 'Tortilla de Claras con Espinacas', 'Tortilla ligera de claras de huevo con espinacas frescas y queso fresco.', 'tortilla-clara-espinacas.jpg', 12, 1, 'Fácil', 85, '2025-12-01 21:27:08'),
(5, 2, 'Pechuga de Pollo con Brócoli al Horno', 'Pechuga de pollo marinada con especias, acompañada de brócoli asado. Bajo en carbohidratos y alto en proteínas.', 'pechuga-pollo-brocoli.jpg', 35, 2, 'Media', 90, '2025-12-01 21:27:08'),
(6, 2, 'Salmón a la Plancha con Espárragos', 'Filete de salmón jugoso con espárragos verdes salteados en aceite de oliva.', 'salmon-plancha-esparragos.jpg', 20, 2, 'Fácil', 93, '2025-12-01 21:27:08'),
(7, 2, 'Ensalada Keto de Aguacate y Gamba', 'Ensalada fresca con gambas, aguacate, lechuga y aliño de limón.', 'ensalada-keto-gamba.jpg', 15, 2, 'Fácil', 87, '2025-12-01 21:27:08'),
(8, 2, 'Calabacín Relleno de Carne Picada', 'Calabacines horneados rellenos de carne de ternera con queso mozzarella.', 'calabacin-carne-picada.jpg', 40, 4, 'Media', 91, '2025-12-01 21:27:08'),
(9, 3, 'Bowl de Quinoa con Garbanzos', 'Bowl nutritivo con quinoa, garbanzos especiados, pimiento, zanahoria y tahini.', 'bowl-quinoa-garbanzos.jpg', 25, 2, 'Fácil', 89, '2025-12-01 21:27:08'),
(10, 3, 'Curry de Lentejas Rojas', 'Curry cremoso de lentejas rojas con leche de coco, tomate y especias aromáticas.', 'curry-lentejas.jpg', 30, 4, 'Media', 94, '2025-12-01 21:27:08'),
(11, 3, 'Hamburguesas de Alubias Negras', 'Hamburguesas vegetales caseras de alubias negras con especias y avena.', 'hamburguesa-alubias-negras.jpg', 35, 4, 'Media', 86, '2025-12-01 21:27:08'),
(12, 3, 'Ensalada de Espinacas con Almendras', 'Ensalada fresca con espinacas, naranja, almendras laminadas y vinagreta de mostaza.', 'ensalada-espinacas.jpg', 10, 2, 'Fácil', 82, '2025-12-01 21:27:08'),
(13, 8, 'Tortilla Española de Calabacín', 'Tortilla jugosa con calabacín, cebolla y huevo. Versión ligera de la clásica tortilla.', 'tortilla-calabacin.jpg', 25, 4, 'Media', 90, '2025-12-01 21:27:08'),
(14, 4, 'Pasta Integral con Champiñones', 'Pasta integral con champiñones salteados, ajo, perejil y queso parmesano.', 'pasta-integral-champiniones.jpg\r\n', 20, 2, 'Fácil', 88, '2025-12-01 21:27:08'),
(15, 4, 'Lasaña de Berenjenas', 'Lasaña sin pasta, usando láminas de berenjena con queso mozzarella y tomate frito.', 'lasania-berenjenas.jpg', 50, 6, 'Difícil', 92, '2025-12-01 21:27:08'),
(16, 4, 'Risotto de Espárragos', 'Cremoso risotto de arroz con espárragos frescos y queso parmesano.', 'risotto-esparragos.jpg', 35, 4, 'Media', 85, '2025-12-01 21:27:08'),
(17, 5, 'Ternera Salteada con Pimientos', 'Tiras de ternera magra salteadas con pimientos de colores y cebolla.', 'ternera-salteada-pimientos.webp', 20, 2, 'Fácil', 87, '2025-12-01 21:27:08'),
(18, 5, 'Pollo al Horno con Boniato', 'Muslos de pollo al horno con batata asada y hierbas aromáticas.', 'pollo-horno-boniato.jpg', 45, 4, 'Media', 91, '2025-12-01 21:27:08'),
(19, 5, 'Ensalada Paleo de Atún', 'Ensalada con atún fresco, lechuga, tomate, pepino y aguacate.', 'ensalada-paleo-atun.jpg', 15, 2, 'Fácil', 84, '2025-12-01 21:27:08'),
(20, 5, 'Lubina al Papillote', 'Lubina al horno en papillote con verduras mediterráneas.', 'lubina-papillote.jpg', 30, 2, 'Media', 89, '2025-12-01 21:27:08'),
(21, 6, 'Ensalada Griega Clásica', 'Ensalada con tomate, pepino, cebolla, pimiento, aceitunas y queso fresco.', 'ensalada-griega.jpg', 10, 2, 'Fácil', 93, '2025-12-01 21:27:08'),
(22, 6, 'Dorada al Horno con Limón', 'Dorada entera al horno con rodajas de limón, ajo y aceite de oliva.', 'dorada-horno-limon.jpg', 35, 2, 'Media', 90, '2025-12-01 21:27:08'),
(23, 6, 'Gazpacho Andaluz', 'Sopa fría de tomate, pepino, pimiento, ajo y aceite de oliva virgen extra.', 'gazpacho-andaluz.jpg', 15, 4, 'Fácil', 88, '2025-12-01 21:27:08'),
(24, 6, 'Calamares a la Plancha', 'Calamares frescos a la plancha con ajo y perejil.', 'calamares-plancha.jpg', 15, 2, 'Fácil', 86, '2025-12-01 21:27:08'),
(25, 7, 'Pechuga de Pavo con Judías Blancas', 'Pechuga de pavo a la plancha con judías blancas cocidas y espinacas.', 'judia-blanca-pavo.jpg', 25, 2, 'Fácil', 91, '2025-12-01 21:27:08'),
(26, 7, 'Atún a la Plancha con Quinoa', 'Filete de atún sellado con quinoa cocida y brócoli al vapor.', 'pescado-plancha-quinoa.jpg', 25, 2, 'Media', 93, '2025-12-01 21:27:08'),
(27, 7, 'Tortilla de Claras con Jamón Cocido', 'Tortilla de claras de huevo con tiras de jamón cocido y tomate.', 'tortilla-francesa.jpg', 10, 1, 'Fácil', 87, '2025-12-01 21:27:08'),
(28, 7, 'Bowl Proteico de Lentejas', 'Bowl con lentejas, huevo cocido, espinacas y semillas de girasol.', 'bowl-proteico-lentejas.jpg', 20, 2, 'Fácil', 89, '2025-12-01 21:27:08'),
(29, 8, 'Merluza al Vapor con Verduras', 'Merluza cocida al vapor con calabacín, zanahoria y brócoli.', 'merluza-vapor.jpg', 20, 2, 'Fácil', 85, '2025-12-01 21:27:08'),
(30, 8, 'Ensalada de Lechuga y Pepino', 'Ensalada fresca y ligera con lechuga, pepino, tomate y vinagre.', 'ensalada-lechuga-pepino.jpg', 8, 2, 'Fácil', 80, '2025-12-01 21:27:08'),
(31, 8, 'Calabaza Asada con Espinacas', 'Rodajas de calabaza asada acompañadas de espinacas salteadas.', 'ensalada-calabaza-espinacas.jpg', 30, 2, 'Fácil', 82, '2025-12-01 21:27:08'),
(32, 8, 'Sopa de Verduras Depurativa', 'Sopa ligera con apio, puerro, zanahoria y calabacín.', 'sopa-verduras.jpg', 35, 4, 'Fácil', 84, '2025-12-01 21:27:08'),
(33, 9, 'Arroz con Pollo y Verduras', 'Arroz blanco cocido con trozos de pollo, pimiento y guisantes.', 'arroz-pollo-verduras.jpg', 30, 4, 'Fácil', 92, '2025-12-01 21:27:08'),
(34, 9, 'Bacalao con Patatas', 'Bacalao al horno con patatas asadas y cebolla.', 'bacalao-patatas.jpg', 40, 4, 'Media', 88, '2025-12-01 21:27:08'),
(35, 9, 'Ensalada de Quinoa y Aguacate', 'Quinoa cocida con aguacate, tomate cherry y limón.', 'ensalada-quinoa-aguacate.jpg', 20, 2, 'Fácil', 86, '2025-12-01 21:27:08'),
(36, 9, 'Pollo al Curry Sin Gluten', 'Pollo en salsa de curry con leche de coco y arroz basmati.', 'pollo-curry.jpg', 35, 4, 'Media', 90, '2025-12-01 21:27:08'),
(37, 10, 'Garbanzos con Espinacas', 'Garbanzos cocidos salteados con espinacas frescas y ajo.', 'garbanzos-espinacas.jpg', 20, 4, 'Fácil', 87, '2025-12-01 21:27:08'),
(38, 10, 'Pechuga de Pollo con Coliflor', 'Pechuga de pollo a la plancha con puré de coliflor y aceite de oliva.', 'pechuga-coliflor.jpg', 25, 2, 'Fácil', 85, '2025-12-01 21:27:08'),
(39, 10, 'Lentejas Estofadas', 'Lentejas cocidas con zanahoria, cebolla y pimiento en caldo de verduras.', 'lentejas-estoadas.jpg', 45, 6, 'Media', 91, '2025-12-01 21:27:08'),
(40, 10, 'Ensalada de Alubias Negras', 'Alubias negras con tomate, pimiento, cebolla y cilantro fresco.', 'alubias-negras.jpg', 15, 4, 'Fácil', 83, '2025-12-01 21:27:08'),
(41, 11, 'Salmón con Jengibre y Espárragos', 'Salmón marinado con jengibre fresco, acompañado de espárragos al vapor.', 'salmon-esparragos.jpg', 25, 2, 'Media', 92, '2025-12-01 21:27:08'),
(42, 11, 'Bowl de Cúrcuma y Garbanzos', 'Garbanzos especiados con cúrcuma, servidos con espinacas y quinoa.', 'bowl-garbanzos-curcuma.jpg', 25, 2, 'Fácil', 88, '2025-12-01 21:27:08'),
(43, 11, 'Ensalada de Remolacha y Nueces', 'Remolacha asada con nueces, espinacas y vinagreta de limón.', 'ensalada-remolacha.jpg', 30, 2, 'Fácil', 85, '2025-12-01 21:27:08'),
(44, 11, 'Té Verde con Jengibre y Limón', 'Infusión caliente de té verde con rodajas de jengibre fresco y limón.', 'te-verde-limon.jpg', 5, 1, 'Fácil', 80, '2025-12-01 21:27:08'),
(45, 12, 'Zumo Verde Detox', 'Batido de espinacas, apio, pepino, manzana verde y limón.', 'zumo-detox.jpg', 10, 1, 'Fácil', 86, '2025-12-01 21:27:08'),
(46, 12, 'Ensalada Depurativa de Lechuga', 'Ensalada con lechuga, pepino, apio y limón.', 'ensalada-depurativa.jpg', 10, 2, 'Fácil', 82, '2025-12-01 21:27:08'),
(47, 12, 'Sopa de Puerro y Apio', 'Sopa ligera con puerro, apio, calabacín y caldo de verduras.', 'sopa-puerro.jpg', 30, 4, 'Fácil', 84, '2025-12-01 21:27:08'),
(48, 12, 'Agua Detox de Pepino y Menta', 'Agua infusionada con rodajas de pepino, limón y hojas de menta.', 'agua-detox.jpg', 5, 1, 'Fácil', 78, '2025-12-01 21:27:08'),
(49, 13, 'Tostada de Pan Integral con Plátano', 'Pan integral tostado con rodajas de plátano y canela.', 'pan-integral-platano.jpg', 5, 1, 'Fácil', 88, '2025-12-01 21:27:08'),
(50, 13, 'Batido de Avena y Manzana', 'Batido con avena, manzana, leche y canela.', 'batido-avena-manzana.jpg', 5, 1, 'Fácil', 86, '2025-12-01 21:27:08'),
(51, 13, 'Bowl de Arroz con Pavo', 'Arroz blanco con tiras de pavo y brócoli al vapor.', 'bowl-arroz-pavo.jpg', 20, 1, 'Fácil', 85, '2025-12-01 21:27:08'),
(52, 13, 'Smoothie de Plátano y Dátiles', 'Batido energético con plátano, dátiles, avena y leche.', 'batido-platano-datiles.jpg', 5, 1, 'Fácil', 83, '2025-12-01 21:27:08'),
(53, 14, 'Pollo con Arroz Integral', 'Pechuga de pollo a la plancha con arroz integral y brócoli.', 'bowl-arroz-integral.jpg', 30, 2, 'Fácil', 94, '2025-12-01 21:27:08'),
(54, 14, 'Batido Proteico de Yogur', 'Batido de yogur griego, plátano, fresas y almendras.', 'batido-proteico.jpg', 5, 1, 'Fácil', 91, '2025-12-01 21:27:08'),
(55, 14, 'Tortilla de Huevo con Aguacate', 'Tortilla de huevo entero con aguacate machacado y tostada integral.', 'tortilla-aguacate.jpg', 15, 1, 'Fácil', 89, '2025-12-01 21:27:08'),
(56, 14, 'Salmón con Quinoa y Espinacas', 'Filete de salmón con quinoa cocida y espinacas salteadas.', 'salmon-quinoa-espinacas.jpg', 25, 2, 'Media', 92, '2025-12-01 21:27:08'),
(57, 15, 'Pollo Asado con Verduras', 'Pollo entero asado con zanahoria, cebolla y pimiento para múltiples comidas.', 'pollo-verdura.jpg', 90, 8, 'Media', 93, '2025-12-01 21:27:08'),
(58, 15, 'Lentejas con Arroz', 'Guiso de lentejas con arroz, zanahoria, cebolla y pimiento.', 'lentejas-arroz.jpg', 50, 8, 'Fácil', 90, '2025-12-01 21:27:08'),
(59, 15, 'Ternera Guisada', 'Estofado de ternera con zanahoria, cebolla y tomate.', 'ternera-guisada.jpg', 120, 8, 'Media', 91, '2025-12-01 21:27:08'),
(60, 15, 'Pasta Integral con Verduras', 'Pasta integral con calabacín, pimiento, berenjena y tomate.', 'pasta-verdura.jpg', 30, 6, 'Fácil', 87, '2025-12-01 21:27:08'),
(61, 16, 'Hummus de Garbanzos', 'Paté cremoso de garbanzos con tahini, limón y ajo.', 'hummus-garbanzo.jpg', 10, 4, 'Fácil', 92, '2025-12-01 21:27:08'),
(62, 16, 'Palitos de Zanahoria con Guacamole', 'Bastones de zanahoria cruda con salsa de aguacate.', 'zanahoria-guacamole.jpg', 10, 2, 'Fácil', 85, '2025-12-01 21:27:08'),
(63, 16, 'Almendras Tostadas con Especias', 'Almendras tostadas con pimentón y sal marina.', 'almendras-tostadas.jpg', 15, 4, 'Fácil', 83, '2025-12-01 21:27:08'),
(64, 16, 'Energy Balls de Dátiles', 'Bolitas energéticas de dátiles, nueces y cacao.', 'energy-datiles.jpg', 15, 10, 'Fácil', 88, '2025-12-01 21:27:08'),
(65, 17, 'Wrap de Pollo y Lechuga', 'Tortilla integral con pollo, lechuga, tomate y yogur natural.', 'wraps-pollo.jpg', 10, 1, 'Fácil', 90, '2025-12-01 21:27:08'),
(66, 17, 'Ensalada César Ligera', 'Lechuga romana con pollo, queso parmesano y aliño de yogur.', 'ensalada-cesar.jpg', 12, 2, 'Fácil', 88, '2025-12-01 21:27:08'),
(67, 17, 'Bowl Express de Atún', 'Bowl con atún, arroz, aguacate, tomate y maíz.', 'bowl-atun.jpg', 10, 1, 'Fácil', 86, '2025-12-01 21:27:08'),
(68, 17, 'Bocadillo de Pavo y Aguacate', 'Pan integral con pavo, aguacate, lechuga y tomate.', 'bocadillo-pavo-aguacate.jpg', 8, 1, 'Fácil', 84, '2025-12-01 21:27:08'),
(69, 18, 'Paella de Verduras y Pollo', 'Arroz con pollo, pimiento, guisantes y azafrán.', 'paella-pollo-verduras.jpg', 45, 4, 'Media', 95, '2025-12-01 21:27:08'),
(70, 18, 'Cordero al Horno con Patatas', 'Pierna de cordero asada con patatas, ajo y romero.', 'cordero-horno-patatas.jpg', 90, 6, 'Difícil', 92, '2025-12-01 21:27:08'),
(71, 18, 'Cocido Completo', 'Garbanzos con carne, zanahoria, puerro y repollo.', 'cocido-completo.jpg', 120, 8, 'Difícil', 94, '2025-12-01 21:27:08'),
(72, 18, 'Lasaña de Carne', 'Lasaña tradicional con carne picada, bechamel y queso.', 'lasaña-carne.jpg', 60, 6, 'Difícil', 93, '2025-12-01 21:27:08'),
(73, 19, 'Yogur con Frutos Rojos', 'Yogur natural con fresas, frambuesas y nueces picadas.', 'yogur-frutos-bosque.jpg', 5, 2, 'Fácil', 87, '2025-12-01 21:27:08'),
(74, 19, 'Manzana Asada con Canela', 'Manzana al horno con canela y un toque de miel.', 'manzana-canela.jpg', 30, 2, 'Fácil', 85, '2025-12-01 21:27:08'),
(75, 19, 'Mousse de Chocolate Negro', 'Mousse ligera de chocolate negro 70% con aguacate.', 'mousse-chocolate.jpg', 15, 4, 'Media', 90, '2025-12-01 21:27:08'),
(76, 19, 'Pera con Queso Fresco', 'Rodajas de pera con queso fresco y nueces.', 'pera-queso.jpg', 5, 2, 'Fácil', 82, '2025-12-01 21:27:08'),
(77, 20, 'Smoothie Tropical', 'Batido de mango, piña, plátano y leche de coco.', 'smoothie-tropical.jpg', 5, 1, 'Fácil', 91, '2025-12-01 21:27:08'),
(78, 20, 'Batido Verde Energizante', 'Batido de espinacas, plátano, manzana y jengibre.', 'batido-verde.jpg', 5, 1, 'Fácil', 88, '2025-12-01 21:27:08'),
(79, 20, 'Smoothie de Frutos Rojos', 'Batido de fresas, cerezas, yogur natural y miel.', 'smoothie-frutos-bosque.jpg', 5, 1, 'Fácil', 89, '2025-12-01 21:27:08'),
(80, 20, 'Limonada Natural', 'Limonada casera con limón fresco, agua y miel.', 'limonada-natural.jpg', 5, 4, 'Fácil', 85, '2025-12-01 21:27:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta_alergeno`
--

CREATE TABLE `receta_alergeno` (
  `id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL,
  `alergeno_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `receta_alergeno`
--

INSERT INTO `receta_alergeno` (`id`, `receta_id`, `alergeno_id`) VALUES
(1, 2, 1),
(2, 2, 3),
(3, 3, 2),
(4, 4, 3),
(7, 7, 8),
(8, 8, 7),
(10, 14, 1),
(11, 15, 2),
(12, 17, 6),
(13, 18, 7),
(14, 19, 7),
(17, 24, 14),
(18, 25, 7),
(19, 26, 7),
(20, 27, 3),
(21, 28, 3),
(22, 29, 7),
(23, 33, 7),
(24, 34, 7),
(25, 36, 7),
(26, 38, 7),
(27, 41, 7),
(28, 45, 9),
(29, 46, 9),
(30, 47, 9),
(31, 48, 9),
(32, 49, 1),
(33, 50, 2),
(34, 51, 7),
(35, 52, 2),
(36, 53, 7),
(37, 54, 2),
(38, 54, 4),
(39, 55, 3),
(40, 56, 7),
(41, 57, 7),
(42, 58, 7),
(43, 59, 7),
(44, 60, 1),
(45, 61, 11),
(46, 63, 4),
(47, 64, 4),
(48, 65, 1),
(49, 65, 2),
(50, 66, 2),
(51, 67, 7),
(52, 68, 1),
(53, 69, 7),
(54, 70, 7),
(55, 71, 7),
(56, 72, 1),
(57, 72, 2),
(58, 73, 2),
(59, 73, 4),
(60, 75, 4),
(61, 76, 2),
(62, 76, 4),
(63, 77, 4),
(64, 78, 2),
(65, 79, 2),
(67, 5, 7),
(68, 6, 7),
(72, 13, 3),
(73, 22, 7),
(75, 20, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta_ingrediente`
--

CREATE TABLE `receta_ingrediente` (
  `id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL,
  `ingrediente_id` int(11) NOT NULL,
  `cantidad` double NOT NULL,
  `medida` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `receta_ingrediente`
--

INSERT INTO `receta_ingrediente` (`id`, `receta_id`, `ingrediente_id`, `cantidad`, `medida`) VALUES
(5, 2, 66, 60, 'g'),
(6, 2, 34, 80, 'g'),
(7, 2, 77, 100, 'g'),
(8, 2, 103, 2, 'g'),
(9, 3, 7, 50, 'g'),
(10, 3, 22, 120, 'g'),
(11, 3, 36, 100, 'g'),
(12, 3, 69, 100, 'ml'),
(13, 4, 78, 150, 'g'),
(14, 4, 7, 80, 'g'),
(15, 4, 103, 2, 'g'),
(16, 4, 100, 5, 'ml'),
(25, 7, 51, 150, 'g'),
(26, 7, 34, 100, 'g'),
(27, 7, 6, 80, 'g'),
(28, 7, 100, 15, 'ml'),
(29, 7, 24, 30, 'g'),
(30, 8, 11, 400, 'g'),
(31, 8, 39, 300, 'g'),
(32, 8, 1, 100, 'g'),
(33, 8, 2, 80, 'g'),
(34, 8, 3, 10, 'g'),
(35, 9, 68, 150, 'g'),
(36, 9, 56, 200, 'g'),
(37, 9, 4, 80, 'g'),
(38, 9, 100, 10, 'ml'),
(39, 10, 58, 300, 'g'),
(40, 10, 138, 200, 'ml'),
(41, 10, 2, 100, 'g'),
(42, 10, 3, 15, 'g'),
(43, 10, 142, 5, 'g'),
(44, 11, 59, 300, 'g'),
(45, 11, 2, 50, 'g'),
(46, 11, 3, 10, 'g'),
(47, 11, 67, 30, 'g'),
(48, 12, 7, 100, 'g'),
(49, 12, 23, 100, 'g'),
(50, 12, 82, 30, 'g'),
(51, 12, 100, 10, 'ml'),
(56, 14, 64, 200, 'g'),
(57, 14, 18, 200, 'g'),
(58, 14, 3, 10, 'g'),
(59, 14, 100, 15, 'ml'),
(60, 14, 116, 10, 'g'),
(61, 15, 10, 500, 'g'),
(62, 15, 39, 400, 'g'),
(63, 15, 127, 200, 'g'),
(64, 15, 145, 300, 'g'),
(65, 15, 75, 100, 'g'),
(66, 16, 63, 300, 'g'),
(67, 16, 20, 200, 'g'),
(68, 16, 2, 80, 'g'),
(69, 16, 76, 50, 'g'),
(70, 17, 39, 250, 'g'),
(71, 17, 4, 200, 'g'),
(72, 17, 2, 80, 'g'),
(73, 17, 100, 10, 'ml'),
(74, 17, 125, 10, 'ml'),
(75, 18, 38, 300, 'g'),
(76, 18, 132, 300, 'g'),
(77, 18, 100, 15, 'ml'),
(78, 18, 141, 5, 'g'),
(79, 19, 46, 150, 'g'),
(80, 19, 6, 100, 'g'),
(81, 19, 1, 100, 'g'),
(82, 19, 12, 80, 'g'),
(83, 19, 100, 15, 'ml'),
(89, 21, 1, 200, 'g'),
(90, 21, 12, 150, 'g'),
(91, 21, 2, 80, 'g'),
(92, 21, 4, 100, 'g'),
(93, 21, 100, 20, 'ml'),
(98, 23, 1, 500, 'g'),
(99, 23, 12, 100, 'g'),
(100, 23, 4, 80, 'g'),
(101, 23, 3, 10, 'g'),
(102, 23, 100, 30, 'ml'),
(103, 23, 123, 20, 'ml'),
(104, 24, 52, 250, 'g'),
(105, 24, 3, 10, 'g'),
(106, 24, 116, 10, 'g'),
(107, 24, 100, 10, 'ml'),
(108, 25, 42, 200, 'g'),
(109, 25, 57, 250, 'g'),
(110, 25, 1, 100, 'g'),
(111, 25, 100, 10, 'ml'),
(112, 26, 46, 200, 'g'),
(113, 26, 68, 150, 'g'),
(114, 26, 8, 150, 'g'),
(115, 26, 100, 10, 'ml'),
(116, 27, 78, 150, 'g'),
(117, 27, 43, 80, 'g'),
(118, 27, 100, 5, 'ml'),
(119, 28, 55, 200, 'g'),
(120, 28, 77, 100, 'g'),
(121, 28, 7, 80, 'g'),
(122, 28, 97, 10, 'g'),
(123, 29, 47, 200, 'g'),
(124, 29, 11, 100, 'g'),
(125, 29, 5, 100, 'g'),
(126, 29, 8, 100, 'g'),
(127, 30, 6, 150, 'g'),
(128, 30, 12, 120, 'g'),
(129, 30, 1, 80, 'g'),
(130, 30, 100, 10, 'ml'),
(131, 30, 24, 20, 'g'),
(132, 31, 19, 300, 'g'),
(133, 31, 7, 100, 'g'),
(134, 31, 100, 10, 'ml'),
(135, 31, 3, 5, 'g'),
(136, 32, 13, 100, 'g'),
(137, 32, 14, 100, 'g'),
(138, 32, 5, 100, 'g'),
(139, 32, 11, 100, 'g'),
(140, 32, 129, 1000, 'ml'),
(141, 33, 63, 300, 'g'),
(142, 33, 38, 250, 'g'),
(143, 33, 4, 100, 'g'),
(144, 33, 62, 100, 'g'),
(145, 33, 100, 15, 'ml'),
(146, 34, 48, 250, 'g'),
(147, 34, 133, 400, 'g'),
(148, 34, 2, 100, 'g'),
(149, 34, 100, 15, 'ml'),
(150, 35, 68, 150, 'g'),
(151, 35, 34, 100, 'g'),
(152, 35, 1, 100, 'g'),
(153, 35, 24, 30, 'g'),
(154, 35, 100, 10, 'ml'),
(155, 36, 38, 300, 'g'),
(156, 36, 138, 200, 'ml'),
(157, 36, 63, 200, 'g'),
(158, 36, 2, 80, 'g'),
(159, 36, 142, 5, 'g'),
(160, 37, 56, 300, 'g'),
(161, 37, 7, 200, 'g'),
(162, 37, 3, 10, 'g'),
(163, 37, 100, 10, 'ml'),
(164, 38, 38, 200, 'g'),
(165, 38, 9, 300, 'g'),
(166, 38, 100, 10, 'ml'),
(167, 39, 55, 400, 'g'),
(168, 39, 5, 100, 'g'),
(169, 39, 2, 80, 'g'),
(170, 39, 4, 80, 'g'),
(171, 39, 100, 10, 'ml'),
(172, 40, 59, 250, 'g'),
(173, 40, 1, 100, 'g'),
(174, 40, 4, 80, 'g'),
(175, 40, 2, 50, 'g'),
(176, 40, 117, 10, 'g'),
(177, 41, 45, 200, 'g'),
(178, 41, 118, 10, 'g'),
(179, 41, 20, 200, 'g'),
(180, 41, 100, 10, 'ml'),
(181, 42, 56, 250, 'g'),
(182, 42, 142, 5, 'g'),
(183, 42, 7, 100, 'g'),
(184, 42, 100, 10, 'ml'),
(185, 43, 16, 200, 'g'),
(186, 43, 83, 40, 'g'),
(187, 43, 7, 80, 'g'),
(188, 43, 100, 15, 'ml'),
(189, 44, 143, 2, 'g'),
(190, 44, 118, 5, 'g'),
(191, 44, 24, 20, 'g'),
(192, 45, 7, 50, 'g'),
(193, 45, 13, 50, 'g'),
(194, 45, 12, 80, 'g'),
(195, 45, 21, 100, 'g'),
(196, 45, 24, 30, 'g'),
(197, 46, 6, 150, 'g'),
(198, 46, 12, 100, 'g'),
(199, 46, 13, 80, 'g'),
(200, 46, 24, 30, 'g'),
(201, 46, 100, 10, 'ml'),
(202, 47, 14, 150, 'g'),
(203, 47, 13, 100, 'g'),
(204, 47, 11, 100, 'g'),
(205, 47, 129, 800, 'ml'),
(206, 48, 12, 80, 'g'),
(207, 48, 24, 30, 'g'),
(208, 48, 144, 5, 'g'),
(209, 49, 66, 60, 'g'),
(210, 49, 22, 100, 'g'),
(211, 49, 119, 2, 'g'),
(212, 50, 67, 40, 'g'),
(213, 50, 21, 150, 'g'),
(214, 50, 69, 200, 'ml'),
(215, 50, 119, 2, 'g'),
(216, 51, 63, 200, 'g'),
(217, 51, 42, 150, 'g'),
(218, 51, 8, 150, 'g'),
(219, 52, 22, 120, 'g'),
(220, 52, 136, 40, 'g'),
(221, 52, 67, 30, 'g'),
(222, 52, 69, 200, 'ml'),
(223, 53, 38, 200, 'g'),
(224, 53, 63, 200, 'g'),
(225, 53, 5, 80, 'g'),
(226, 53, 100, 10, 'ml'),
(227, 54, 72, 150, 'g'),
(228, 54, 22, 100, 'g'),
(229, 54, 25, 80, 'g'),
(230, 54, 82, 20, 'g'),
(231, 55, 77, 150, 'g'),
(232, 55, 34, 80, 'g'),
(233, 55, 1, 50, 'g'),
(234, 55, 100, 5, 'ml'),
(235, 56, 45, 200, 'g'),
(236, 56, 68, 150, 'g'),
(237, 56, 7, 100, 'g'),
(238, 56, 100, 10, 'ml'),
(239, 57, 38, 800, 'g'),
(240, 57, 5, 200, 'g'),
(241, 57, 2, 150, 'g'),
(242, 57, 4, 150, 'g'),
(243, 57, 100, 20, 'ml'),
(244, 58, 55, 400, 'g'),
(245, 58, 63, 300, 'g'),
(246, 58, 5, 100, 'g'),
(247, 58, 2, 80, 'g'),
(248, 58, 100, 15, 'ml'),
(249, 59, 39, 600, 'g'),
(250, 59, 5, 150, 'g'),
(251, 59, 2, 120, 'g'),
(252, 59, 1, 200, 'g'),
(253, 59, 100, 15, 'ml'),
(254, 60, 64, 400, 'g'),
(255, 60, 11, 150, 'g'),
(256, 60, 4, 100, 'g'),
(257, 60, 10, 150, 'g'),
(258, 60, 100, 15, 'ml'),
(259, 61, 56, 300, 'g'),
(260, 61, 99, 40, 'g'),
(261, 61, 24, 40, 'g'),
(262, 61, 3, 10, 'g'),
(263, 61, 100, 20, 'ml'),
(264, 62, 5, 200, 'g'),
(265, 62, 34, 150, 'g'),
(266, 62, 24, 20, 'g'),
(267, 62, 103, 2, 'g'),
(268, 63, 82, 200, 'g'),
(269, 63, 105, 5, 'g'),
(270, 63, 107, 3, 'g'),
(271, 64, 136, 200, 'g'),
(272, 64, 83, 100, 'g'),
(273, 64, 139, 30, 'g'),
(274, 65, 66, 80, 'g'),
(275, 65, 38, 150, 'g'),
(276, 65, 6, 50, 'g'),
(277, 65, 1, 50, 'g'),
(278, 65, 71, 50, 'g'),
(279, 66, 6, 150, 'g'),
(280, 66, 38, 150, 'g'),
(281, 66, 76, 30, 'g'),
(282, 66, 100, 15, 'ml'),
(283, 67, 46, 120, 'g'),
(284, 67, 63, 150, 'g'),
(285, 67, 34, 60, 'g'),
(286, 67, 1, 60, 'g'),
(287, 67, 135, 50, 'g'),
(288, 68, 66, 80, 'g'),
(289, 68, 42, 80, 'g'),
(290, 68, 34, 50, 'g'),
(291, 68, 6, 30, 'g'),
(292, 68, 1, 40, 'g'),
(293, 69, 63, 400, 'g'),
(294, 69, 38, 300, 'g'),
(295, 69, 4, 150, 'g'),
(296, 69, 62, 150, 'g'),
(297, 69, 140, 1, 'g'),
(298, 69, 100, 20, 'ml'),
(299, 70, 41, 600, 'g'),
(300, 70, 133, 600, 'g'),
(301, 70, 3, 20, 'g'),
(302, 70, 141, 10, 'g'),
(303, 70, 100, 20, 'ml'),
(304, 71, 56, 500, 'g'),
(305, 71, 39, 400, 'g'),
(306, 71, 5, 150, 'g'),
(307, 71, 14, 150, 'g'),
(308, 71, 134, 200, 'g'),
(309, 72, 64, 300, 'g'),
(310, 72, 39, 400, 'g'),
(311, 72, 145, 400, 'g'),
(312, 72, 75, 150, 'g'),
(313, 72, 127, 200, 'g'),
(314, 73, 71, 200, 'g'),
(315, 73, 25, 80, 'g'),
(316, 73, 137, 50, 'g'),
(317, 73, 83, 20, 'g'),
(318, 74, 21, 200, 'g'),
(319, 74, 119, 3, 'g'),
(320, 74, 122, 10, 'g'),
(321, 75, 131, 150, 'g'),
(322, 75, 34, 100, 'g'),
(323, 75, 122, 20, 'g'),
(324, 76, 31, 150, 'g'),
(325, 76, 74, 100, 'g'),
(326, 76, 83, 20, 'g'),
(327, 77, 36, 100, 'g'),
(328, 77, 27, 100, 'g'),
(329, 77, 22, 100, 'g'),
(330, 77, 138, 150, 'ml'),
(331, 78, 7, 50, 'g'),
(332, 78, 22, 120, 'g'),
(333, 78, 21, 100, 'g'),
(334, 78, 118, 5, 'g'),
(335, 78, 69, 150, 'ml'),
(336, 79, 25, 100, 'g'),
(337, 79, 33, 80, 'g'),
(338, 79, 71, 150, 'g'),
(339, 79, 122, 15, 'g'),
(340, 80, 24, 100, 'g'),
(341, 80, 122, 50, 'g'),
(343, 1, 67, 50, 'g'),
(344, 1, 22, 100, 'g'),
(345, 1, 25, 80, 'g'),
(346, 1, 122, 10, 'g'),
(347, 5, 38, 200, 'g'),
(348, 5, 8, 300, 'g'),
(349, 5, 100, 10, 'ml'),
(350, 5, 103, 3, 'g'),
(351, 6, 45, 200, 'g'),
(352, 6, 20, 200, 'g'),
(353, 6, 100, 10, 'ml'),
(354, 6, 24, 20, 'g'),
(361, 13, 11, 300, 'g'),
(362, 13, 2, 100, 'g'),
(363, 13, 77, 400, 'g'),
(364, 13, 100, 20, 'ml'),
(365, 22, 49, 300, 'g'),
(366, 22, 24, 50, 'g'),
(367, 22, 3, 10, 'g'),
(368, 22, 100, 15, 'ml'),
(371, 20, 50, 250, 'g'),
(372, 20, 1, 100, 'g'),
(373, 20, 11, 80, 'g'),
(374, 20, 24, 30, 'g'),
(375, 20, 100, 10, 'ml');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta_tag`
--

CREATE TABLE `receta_tag` (
  `id` int(11) NOT NULL,
  `receta_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `receta_tag`
--

INSERT INTO `receta_tag` (`id`, `receta_id`, `tag_id`) VALUES
(375, 2, 8),
(376, 3, 20),
(377, 4, 11),
(380, 7, 8),
(381, 8, 2),
(382, 9, 12),
(383, 10, 12),
(384, 11, 12),
(385, 12, 19),
(387, 14, 7),
(388, 15, 10),
(389, 16, 10),
(390, 17, 9),
(391, 18, 9),
(392, 19, 9),
(394, 21, 10),
(396, 23, 10),
(397, 24, 10),
(398, 25, 2),
(399, 26, 18),
(400, 27, 2),
(401, 28, 16),
(402, 29, 11),
(403, 30, 20),
(404, 31, 12),
(405, 32, 20),
(406, 33, 4),
(407, 34, 10),
(408, 35, 19),
(409, 36, 4),
(410, 37, 16),
(411, 38, 11),
(412, 39, 12),
(413, 40, 12),
(414, 41, 18),
(415, 42, 19),
(416, 43, 19),
(417, 44, 20),
(418, 45, 20),
(419, 46, 20),
(420, 47, 20),
(421, 48, 20),
(422, 49, 21),
(423, 50, 21),
(424, 51, 21),
(425, 52, 21),
(426, 53, 22),
(427, 54, 22),
(428, 55, 21),
(429, 56, 22),
(430, 57, 25),
(431, 58, 16),
(432, 59, 2),
(433, 60, 12),
(434, 61, 12),
(435, 62, 23),
(436, 63, 9),
(437, 64, 21),
(438, 65, 11),
(439, 66, 2),
(440, 67, 18),
(441, 68, 23),
(442, 69, 10),
(443, 70, 25),
(444, 71, 16),
(445, 72, 25),
(446, 73, 17),
(447, 74, 25),
(448, 75, 19),
(449, 76, 23),
(450, 77, 21),
(451, 78, 20),
(452, 79, 19),
(453, 80, 23),
(455, 1, 12),
(456, 5, 2),
(457, 6, 18),
(461, 13, 7),
(462, 22, 18),
(465, 20, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`id`, `nombre`) VALUES
(2, 'ROLE_ADMIN'),
(1, 'ROLE_USER');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tag_saludable`
--

CREATE TABLE `tag_saludable` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tag_saludable`
--

INSERT INTO `tag_saludable` (`id`, `nombre`) VALUES
(1, '#BajoEnCalorias'),
(2, '#AltoEnProteinas'),
(3, '#BajoEnCarbohidratos'),
(4, '#SinGluten'),
(5, '#SinLactosa'),
(6, '#Vegano'),
(7, '#Vegetariano'),
(8, '#Keto'),
(9, '#Paleo'),
(10, '#Mediterraneo'),
(11, '#BajoEnGrasas'),
(12, '#AltoEnFibra'),
(13, '#SinAzucar'),
(14, '#Diabetico'),
(15, '#Hipertension'),
(16, '#RicoEnHierro'),
(17, '#RicoEnCalcio'),
(18, '#RicoEnOmega3'),
(19, '#Antioxidante'),
(20, '#Detox'),
(21, '#PreEntreno'),
(22, '#PostEntreno'),
(23, '#ParaNinos'),
(24, '#SinFritos'),
(25, '#AlHorno'),
(26, '#Crudo'),
(27, '#Fermentado'),
(28, '#Organico'),
(29, '#SinProcesados'),
(30, '#Integral');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `email`, `password`) VALUES
(1, 'afrae2@gmail.com', '$2y$13$GDpiwnbgx/A0X/oNWvkG/u/5NQxDIMwr5YKyKnxWtY/wJLo0631C.'),
(2, 'admin1@gmail.com', '$2y$13$5XDNsEOlDBxHajhbaJB8POLD1YwOhXpa0n7aaoTWC7eVyFhqjj8TK'),
(4, 'prueba@gmail.com', '$2y$13$3em5Uj80xQ4ALBOvCFhVluU0HaSd4mKxIfbeo3uzxnpKJuP.Ssmba'),
(7, 'afrae3@gmail.com', '$2y$13$HaVKS4.rqiuRifdI8eYohef54NH1xDil.0ZN2wKc8cSK39UaxpW4G');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user_role`
--

INSERT INTO `user_role` (`id`, `usuario_id`, `role_id`) VALUES
(2, 2, 2),
(9, 1, 1),
(12, 7, 2),
(15, 4, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alergeno`
--
ALTER TABLE `alergeno`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_881067C7DB38439E` (`usuario_id`),
  ADD KEY `IDX_881067C754F853F8` (`receta_id`);

--
-- Indices de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B6748E7054F853F8` (`receta_id`);

--
-- Indices de la tabla `menu_receta`
--
ALTER TABLE `menu_receta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_63D41196D1DEB0A13E153BCE417EACF` (`menu_semanal_id`,`dia`,`tipo_comida`),
  ADD KEY `IDX_63D41196D1DEB0A1` (`menu_semanal_id`),
  ADD KEY `IDX_63D4119654F853F8` (`receta_id`);

--
-- Indices de la tabla `menu_semanal`
--
ALTER TABLE `menu_semanal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_89D24BADB38439E` (`usuario_id`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `objetivos_nutricionales`
--
ALTER TABLE `objetivos_nutricionales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_usuario` (`usuario_id`),
  ADD KEY `IDX_OBJETIVOS_USUARIO` (`usuario_id`);

--
-- Indices de la tabla `receta`
--
ALTER TABLE `receta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B093494E3397707A` (`categoria_id`);

--
-- Indices de la tabla `receta_alergeno`
--
ALTER TABLE `receta_alergeno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_EA68B3ED54F853F8` (`receta_id`),
  ADD KEY `IDX_EA68B3ED3E89035` (`alergeno_id`);

--
-- Indices de la tabla `receta_ingrediente`
--
ALTER TABLE `receta_ingrediente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F7A6A61354F853F8` (`receta_id`),
  ADD KEY `IDX_F7A6A613769E458D` (`ingrediente_id`);

--
-- Indices de la tabla `receta_tag`
--
ALTER TABLE `receta_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_DB6F5D6D54F853F8` (`receta_id`),
  ADD KEY `IDX_DB6F5D6DBAD26311` (`tag_id`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_57698A6A3A909126` (`nombre`);

--
-- Indices de la tabla `tag_saludable`
--
ALTER TABLE `tag_saludable`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Indices de la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2DE8C6A3DB38439E` (`usuario_id`),
  ADD KEY `IDX_2DE8C6A3D60322AC` (`role_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alergeno`
--
ALTER TABLE `alergeno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `favorito`
--
ALTER TABLE `favorito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=452;

--
-- AUTO_INCREMENT de la tabla `menu_receta`
--
ALTER TABLE `menu_receta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=395;

--
-- AUTO_INCREMENT de la tabla `menu_semanal`
--
ALTER TABLE `menu_semanal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivos_nutricionales`
--
ALTER TABLE `objetivos_nutricionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `receta`
--
ALTER TABLE `receta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `receta_alergeno`
--
ALTER TABLE `receta_alergeno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `receta_ingrediente`
--
ALTER TABLE `receta_ingrediente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT de la tabla `receta_tag`
--
ALTER TABLE `receta_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=467;

--
-- AUTO_INCREMENT de la tabla `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tag_saludable`
--
ALTER TABLE `tag_saludable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD CONSTRAINT `FK_881067C754F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`),
  ADD CONSTRAINT `FK_881067C7DB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `instruccion`
--
ALTER TABLE `instruccion`
  ADD CONSTRAINT `FK_B6748E7054F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`);

--
-- Filtros para la tabla `menu_receta`
--
ALTER TABLE `menu_receta`
  ADD CONSTRAINT `FK_63D4119654F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`),
  ADD CONSTRAINT `FK_63D41196D1DEB0A1` FOREIGN KEY (`menu_semanal_id`) REFERENCES `menu_semanal` (`id`);

--
-- Filtros para la tabla `menu_semanal`
--
ALTER TABLE `menu_semanal`
  ADD CONSTRAINT `FK_89D24BADB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `objetivos_nutricionales`
--
ALTER TABLE `objetivos_nutricionales`
  ADD CONSTRAINT `FK_OBJETIVOS_USUARIO` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `receta`
--
ALTER TABLE `receta`
  ADD CONSTRAINT `FK_B093494E3397707A` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `receta_alergeno`
--
ALTER TABLE `receta_alergeno`
  ADD CONSTRAINT `FK_EA68B3ED3E89035` FOREIGN KEY (`alergeno_id`) REFERENCES `alergeno` (`id`),
  ADD CONSTRAINT `FK_EA68B3ED54F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`);

--
-- Filtros para la tabla `receta_ingrediente`
--
ALTER TABLE `receta_ingrediente`
  ADD CONSTRAINT `FK_F7A6A61354F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`),
  ADD CONSTRAINT `FK_F7A6A613769E458D` FOREIGN KEY (`ingrediente_id`) REFERENCES `ingrediente` (`id`);

--
-- Filtros para la tabla `receta_tag`
--
ALTER TABLE `receta_tag`
  ADD CONSTRAINT `FK_DB6F5D6D54F853F8` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`id`),
  ADD CONSTRAINT `FK_DB6F5D6DBAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tag_saludable` (`id`);

--
-- Filtros para la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `FK_2DE8C6A3D60322AC` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `FK_2DE8C6A3DB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
