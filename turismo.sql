-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-06-2022 a las 01:48:09
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `turismo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat`
--

CREATE TABLE `chat` (
  `IdMensaje` int(11) NOT NULL,
  `idUsuario1` int(11) NOT NULL,
  `idUsuario2` int(11) NOT NULL,
  `Remitente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `idFavoritos` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hotel`
--

CREATE TABLE `hotel` (
  `idHotel` int(11) NOT NULL,
  `Nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Categoria` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Costo` decimal(6,2) DEFAULT NULL,
  `NumHabitacion` int(11) DEFAULT NULL,
  `TipoHabitacion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NumeroExterior` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Numero de direccion que se encuentra en la calle, 200, 240-A',
  `Calle` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Calle en donde se encuentra el hotel',
  `Colonia` mediumtext COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Colonia en donde se encuentra el hotel',
  `Ciudad` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Ciudad donde se encuentra el hotel',
  `Estado` varchar(70) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Estado de la republica mexicana donde se encuentre',
  `CodigoPostal` int(11) DEFAULT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Calificacion` decimal(2,1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `hotel`
--

INSERT INTO `hotel` (`idHotel`, `Nombre`, `Descripcion`, `Imagen`, `Categoria`, `Costo`, `NumHabitacion`, `TipoHabitacion`, `NumeroExterior`, `Calle`, `Colonia`, `Ciudad`, `Estado`, `CodigoPostal`, `Descuento`, `Calificacion`, `idUsuario`) VALUES
(1, 'Posada De Don Vasco', 'El mejor y más grande Hotel de Pátzcuaro BEST WESTERN PLUS Posada de Don Vasco, contamos con 5 hectá', 'https://bwback.axo-corp.com/uploads/images/sliders/best-western-plus-6081a18f2c838.jpg', 'Familiar', '184.00', 20, 'Quad', '450', 'Av. Lazaro Cardenas', 'Centro', 'Patzcuaro', 'Michoacan', 61600, '0.00', '4.3', 2),
(2, 'Gran Hotel Morelia', 'Best Western Plus Gran Hotel de Morelia (antes Fiesta Inn), el mejor y más grande Hotel del Estado d', 'https://images.bestwestern.com/bwi/brochures/70270/photos/1024/9144054.jpg', 'Urbano', '238.00', 10, 'Triple', '2525', 'Ave. Ventura Puente Esq. Ave Carmelinas', 'Col. Felix Ireta', 'Morelia', 'Michoacan', 58070, '10.00', '3.4', 3),
(3, 'Hotel Casino Morelia', 'Hotel Casino, hotel gourmet alojado en un edificio del siglo XVIII, ubicado en el corazón del Centro', 'https://exp.cdn-hotels.com/hotels/1000000/50000/41400/41352/61a4a9b0_z.jpg?impolicy=fcrop&w=500&h=333&q=medium', 'Casino', '250.00', 14, 'Individual', '229', 'Portal Hidalgo', 'Frente a Plaza de Armas', 'Morelia', 'Michoacan', 58000, '0.00', '3.4', 2),
(4, 'Hotel de la Soledad', 'Espléndido edificio colonial del siglo XVII decorado con una vasta colección de obras de arte', 'https://cdn0.bodas.com.mx/vendor/7378/3_2/960/jpg/morelia-hotel-soledad-and-cathedral-at-night-8986_5_107378-159795987647413.jpeg', 'Familiar', '300.00', 11, 'Doble', '90', 'Calle Ignacio Zaragoza', 'Centro', 'Morelia', 'Michoacan', 58000, '0.00', '4.6', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE `imagenes` (
  `idImagenes` int(11) NOT NULL,
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `idPaquete` int(11) DEFAULT NULL,
  `idHotel` int(11) DEFAULT NULL,
  `idViaje` int(11) DEFAULT NULL,
  `idRestaurante` int(11) DEFAULT NULL,
  `idTour` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `idMensajes` int(11) NOT NULL,
  `Contenido` longtext COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizador`
--

CREATE TABLE `organizador` (
  `idOrganizador` int(11) NOT NULL,
  `TipoGuardado` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `idReserva` int(11) DEFAULT NULL,
  `idFavoritos` int(11) DEFAULT NULL,
  `idPaquete` int(11) DEFAULT NULL,
  `idHotel` int(11) DEFAULT NULL,
  `idViaje` int(11) DEFAULT NULL,
  `idRestaurante` int(11) DEFAULT NULL,
  `idTour` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes`
--

CREATE TABLE `paquetes` (
  `idPaquete` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` longtext COLLATE utf8_spanish_ci NOT NULL,
  `Costo` decimal(5,2) NOT NULL COMMENT 'Costo total de todo el paquete',
  `NumeroPaquetes` int(11) NOT NULL COMMENT 'Numero total de reservaciones del paquete antes de agotarce',
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Calificacion` decimal(2,1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva_servicio`
--

CREATE TABLE `reserva_servicio` (
  `idReserva` int(11) NOT NULL,
  `Tipo de servicio` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `FechaEntrada` date DEFAULT NULL,
  `FechaSalida` date DEFAULT NULL,
  `FormaPago` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Forma de pago del la reservacion, solo hay, con tarjeta de debito y de credito.',
  `CostoTotal` decimal(6,2) DEFAULT NULL,
  `CantPersonas` int(11) DEFAULT NULL,
  `confirmado` tinyint(4) DEFAULT NULL,
  `idTurista` int(11) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurantes`
--

CREATE TABLE `restaurantes` (
  `idRestaurante` int(11) NOT NULL,
  `Nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Costo` decimal(6,2) NOT NULL,
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Categoria` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Calificacion` decimal(2,1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `restaurantes`
--

INSERT INTO `restaurantes` (`idRestaurante`, `Nombre`, `Descripcion`, `Costo`, `Imagen`, `Categoria`, `Descuento`, `Calificacion`, `idUsuario`) VALUES
(1, 'Lu Cocina Michoacana', 'Mexicana, Latina, Contemporánea', '450.00', 'https://media-cdn.tripadvisor.com/media/photo-s/1b/8b/dd/17/restaurante-lu-cocina.jpg', 'Contemporanea', '0.00', '4.1', 2),
(2, 'El Infierno Taqueria', 'Los mejores tacos de filete!!!! Calidad a prueba de todo, no fallan, las salsas excepcionales', '50.00', 'https://carta.menu/storage/media/company_images/1041969/XdwkeTaL4k.jpg', 'Taqueria', '10.00', '4.5', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tour`
--

CREATE TABLE `tour` (
  `idTour` int(11) NOT NULL,
  `Nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Cantidad` int(11) NOT NULL COMMENT 'Cantidad total de personas que pueden tomar el tour',
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Costo` decimal(5,2) NOT NULL,
  `Ciudad` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Calificacion` decimal(2,1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tour`
--

INSERT INTO `tour` (`idTour`, `Nombre`, `Descripcion`, `Cantidad`, `Imagen`, `Costo`, `Ciudad`, `Descuento`, `Calificacion`, `idUsuario`) VALUES
(1, 'Matraca', 'Artesanía Mexicana juguete típico Mexicano Para Porras, Fiestas, Partidos, etc.', 1, 'https://i0.wp.com/mas-mexico.com.mx/wp-content/uploads/2018/11/matraca.jpg?resize=770%2C727&ssl=1', '107.00', 'Patzcuaro', '20.00', '3.0', 2),
(2, 'Catrina', 'Una catrina, en el dialecto mexicano, es una persona elegante y de buen vestir, típica de la aristoc', 1, 'https://i.pinimg.com/originals/f7/4f/09/f74f095fe1c40e297b720c9cdae1f7b0.jpg', '550.00', 'Morelia', '20.00', '2.0', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turista`
--

CREATE TABLE `turista` (
  `idTurista` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ApellidoPaterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ApellidoMaterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `turista`
--

INSERT INTO `turista` (`idTurista`, `Nombre`, `ApellidoPaterno`, `ApellidoMaterno`) VALUES
(1, 'Fidel', 'Vanegas', 'Ibañez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `Usuario` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Password` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `TipoUsuario` varchar(45) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Administrador, Turista, Empresa',
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ApellidoPaterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ApellidoMaterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `FechNac` date DEFAULT NULL,
  `RFC` varchar(13) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `Usuario`, `Email`, `Password`, `TipoUsuario`, `Imagen`, `Nombre`, `ApellidoPaterno`, `ApellidoMaterno`, `FechNac`, `RFC`) VALUES
(1, 'Patricio', 'andres_pat@mail.com', '123456', 'Usuario', '1as12', 'Patricio', 'Medina', 'Bastida', '1997-05-21', '123456'),
(2, 'TouristPro', 'TPOficial@hotmail.com', '123456', 'Empresa', '1233', 'Irving', 'Vanegas', 'Carreon', '1996-08-10', '1234567'),
(3, 'Turismo Magico', 'turismo_magico@gmail.com', '123456', 'Empresa', '1233', 'Arturo', 'Vargas', 'Castro', '1996-11-14', '1234567');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes`
--

CREATE TABLE `viajes` (
  `idViaje` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `Descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `Origen` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Destino` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Imagen` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `Costo` decimal(6,2) DEFAULT NULL,
  `NumPlazas` int(11) DEFAULT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Calificacion` decimal(2,1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`IdMensaje`,`idUsuario1`,`idUsuario2`),
  ADD KEY `Foreign_idUsuario2_idx` (`idUsuario2`),
  ADD KEY `Foreign_idUsuario1_idx` (`idUsuario1`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`idFavoritos`,`idUsuario`),
  ADD KEY `Foreign_idUsuario_idx` (`idUsuario`);

--
-- Indices de la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`idHotel`),
  ADD KEY `Tour_Foreign_idUsuario_idx` (`idUsuario`);

--
-- Indices de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`idImagenes`),
  ADD KEY `Imagenes_Foreign_idPaquete_idx` (`idPaquete`),
  ADD KEY `Imagenes_Foreign_idHotel_idx` (`idHotel`),
  ADD KEY `Imagenes_Foreign_idViaje_idx` (`idViaje`),
  ADD KEY `Imagenes_Foreign_idRestaurante_idx` (`idRestaurante`),
  ADD KEY `Imagenes_Foreign_idTour_idx` (`idTour`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`idMensajes`);

--
-- Indices de la tabla `organizador`
--
ALTER TABLE `organizador`
  ADD PRIMARY KEY (`idOrganizador`),
  ADD KEY `Foreign_idReserva_idx` (`idReserva`),
  ADD KEY `Foreign_idFavorito_idx` (`idFavoritos`),
  ADD KEY `Foreign_idPaquete_idx` (`idPaquete`),
  ADD KEY `Foreign_idHotel_idx` (`idHotel`),
  ADD KEY `Foreign_idViaje_idx` (`idViaje`),
  ADD KEY `Foreign_idRestaurante_idx` (`idRestaurante`),
  ADD KEY `Foreign_idTour_idx` (`idTour`);

--
-- Indices de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD PRIMARY KEY (`idPaquete`),
  ADD KEY `Paquetes_Foreign_idUsuario_idx` (`idUsuario`);

--
-- Indices de la tabla `reserva_servicio`
--
ALTER TABLE `reserva_servicio`
  ADD PRIMARY KEY (`idReserva`),
  ADD KEY `Foreingn_idTurista_idx` (`idTurista`),
  ADD KEY `Foreingn_idUsuario_idx` (`idUsuario`);

--
-- Indices de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`idRestaurante`),
  ADD KEY `Res_Foreign_idReserva_idx` (`idUsuario`);

--
-- Indices de la tabla `tour`
--
ALTER TABLE `tour`
  ADD PRIMARY KEY (`idTour`),
  ADD KEY `Tour_Foreign_idReserva_idx` (`idUsuario`);

--
-- Indices de la tabla `turista`
--
ALTER TABLE `turista`
  ADD PRIMARY KEY (`idTurista`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
-- Indices de la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD PRIMARY KEY (`idViaje`),
  ADD KEY `Foreign_idReserva_idx` (`idUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `idFavoritos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `hotel`
--
ALTER TABLE `hotel`
  MODIFY `idHotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `idImagenes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `idMensajes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `organizador`
--
ALTER TABLE `organizador`
  MODIFY `idOrganizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  MODIFY `idPaquete` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reserva_servicio`
--
ALTER TABLE `reserva_servicio`
  MODIFY `idReserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `idRestaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tour`
--
ALTER TABLE `tour`
  MODIFY `idTour` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `turista`
--
ALTER TABLE `turista`
  MODIFY `idTurista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `idViaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `Foreign_idMensaje` FOREIGN KEY (`IdMensaje`) REFERENCES `mensajes` (`idMensajes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idUsuario1` FOREIGN KEY (`idUsuario1`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idUsuario2` FOREIGN KEY (`idUsuario2`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `Hotel_Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `Imagenes_Foreign_idHotel` FOREIGN KEY (`idHotel`) REFERENCES `hotel` (`idHotel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Imagenes_Foreign_idPaquete` FOREIGN KEY (`idPaquete`) REFERENCES `paquetes` (`idPaquete`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Imagenes_Foreign_idRestaurante` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurantes` (`idRestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Imagenes_Foreign_idTour` FOREIGN KEY (`idTour`) REFERENCES `tour` (`idTour`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Imagenes_Foreign_idViaje` FOREIGN KEY (`idViaje`) REFERENCES `viajes` (`idViaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `organizador`
--
ALTER TABLE `organizador`
  ADD CONSTRAINT `Foreign_idFavorito` FOREIGN KEY (`idFavoritos`) REFERENCES `favoritos` (`idFavoritos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idHotel` FOREIGN KEY (`idHotel`) REFERENCES `hotel` (`idHotel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idPaquete` FOREIGN KEY (`idPaquete`) REFERENCES `paquetes` (`idPaquete`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idReserva` FOREIGN KEY (`idReserva`) REFERENCES `reserva_servicio` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idRestaurante` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurantes` (`idRestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idTour` FOREIGN KEY (`idTour`) REFERENCES `tour` (`idTour`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreign_idViaje` FOREIGN KEY (`idViaje`) REFERENCES `viajes` (`idViaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD CONSTRAINT `Paquetes_Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `reserva_servicio`
--
ALTER TABLE `reserva_servicio`
  ADD CONSTRAINT `Foreingn_idTurista` FOREIGN KEY (`idTurista`) REFERENCES `turista` (`idTurista`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Foreingn_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD CONSTRAINT `Res_Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tour`
--
ALTER TABLE `tour`
  ADD CONSTRAINT `Tour_Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `Viajes_Foreign_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
