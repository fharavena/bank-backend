-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2021 a las 04:30:33
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `transferencia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destinatario`
--

CREATE TABLE `destinatario` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `tipo_cuentaid` int(11) NOT NULL,
  `banco_id` int(11) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `rut` varchar(9) NOT NULL,
  `correo` varchar(64) NOT NULL,
  `telefono` int(9) NOT NULL,
  `numero_cuenta` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `destinatario`
--

INSERT INTO `destinatario` (`id`, `userid`, `tipo_cuentaid`, `banco_id`, `nombre`, `rut`, `correo`, `telefono`, `numero_cuenta`) VALUES
(108, 1, 1, 1, '1', '1', '1', 1, 1),
(109, 1, 3, 2, '11', '11', '11', 11, 11),
(110, 1, 2, 7, '111', '111', '111', 111, 111),
(111, 1, 2, 2, '2', '2', '2', 2, 2),
(112, 1, 4, 4, '3', '3', '3', 3, 11),
(113, 1, 3, 3, '3', '3', '3', 3, 333),
(115, 1, 1, 1, 'nombre1', 'rut1', 'correo@n.cl', 111111111, 123456);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cuenta`
--

CREATE TABLE `tipo_cuenta` (
  `id` int(11) NOT NULL,
  `valor` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_cuenta`
--

INSERT INTO `tipo_cuenta` (`id`, `valor`) VALUES
(1, 'Corriente'),
(2, 'Vista'),
(3, 'Ahorro'),
(4, 'Chequera Electronica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transferencia`
--

CREATE TABLE `transferencia` (
  `id` int(11) NOT NULL,
  `destinatarioid` int(11) NOT NULL,
  `monto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `transferencia`
--

INSERT INTO `transferencia` (`id`, `destinatarioid`, `monto`) VALUES
(3, 115, 1000),
(4, 115, 111),
(5, 110, 11),
(6, 115, 11),
(7, 111, 333),
(8, 108, 1),
(9, 108, 1),
(10, 115, 1),
(11, 115, 1),
(12, 115, 5555555),
(13, 111, 333),
(14, 115, 11),
(15, 110, 321),
(16, 110, 32),
(17, 109, 321),
(18, 109, 455),
(19, 110, 555);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `rut` varchar(9) NOT NULL,
  `correo` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `nombre`, `rut`, `correo`) VALUES
(1, 'test', '11111111', 'test@n.cl');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `destinatario`
--
ALTER TABLE `destinatario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cinco_unicas` (`userid`,`banco_id`,`tipo_cuentaid`,`rut`,`numero_cuenta`) USING BTREE,
  ADD KEY `fk_tipo_cuenta` (`tipo_cuentaid`),
  ADD KEY `fk_banco` (`banco_id`);

--
-- Indices de la tabla `tipo_cuenta`
--
ALTER TABLE `tipo_cuenta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transferencia`
--
ALTER TABLE `transferencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_destinatario` (`destinatarioid`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `destinatario`
--
ALTER TABLE `destinatario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT de la tabla `tipo_cuenta`
--
ALTER TABLE `tipo_cuenta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `transferencia`
--
ALTER TABLE `transferencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `destinatario`
--
ALTER TABLE `destinatario`
  ADD CONSTRAINT `fk_tipo_cuenta` FOREIGN KEY (`tipo_cuentaid`) REFERENCES `tipo_cuenta` (`id`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userid`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `transferencia`
--
ALTER TABLE `transferencia`
  ADD CONSTRAINT `fk_destinatario` FOREIGN KEY (`destinatarioid`) REFERENCES `destinatario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
