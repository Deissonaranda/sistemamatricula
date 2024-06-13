-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-05-2024 a las 21:21:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_matricula`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GUARDAR_MATRICULA` (`nIdTipoMatricula` INT, `cIe_Antigua` VARCHAR(100), `cArchivoDocumentacion` VARCHAR(255), `nTipoIdentificacion` INT, `nNumeroDocumento` INT, `cNombreAlumno` VARCHAR(100), `cApellidoAlumno` VARCHAR(100), `nIdNivel` INT, `nIdGrado` INT, `nIdUsuario` INT)   BEGIN
	INSERT INTO matricula(idTipoMatricula,ie_Antigua,archivoDocumentacion,tipoIdentificacion,numeroDocumento,nombreAlumno,
    apellidoAlumno,idNivel,idGrado,estado,idusuario) VALUES(nIdTipoMatricula,cIe_Antigua,cArchivoDocumentacion,nTipoIdentificacion,nNumeroDocumento,
    cNombreAlumno,cApellidoAlumno,nIdNivel,nIdGrado,'Pendiente',nIdUsuario);
    
	UPDATE vacantes SET vacantesDisponibles = vacantesDisponibles - 1
	WHERE idNivel = nIdNivel AND idGrado= nIdGrado;
    
    commit;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE `grado` (
  `idGrado` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`idGrado`, `descripcion`) VALUES
(1, '1° grado'),
(2, '2° grado'),
(3, '3° grado'),
(4, '4° grado'),
(5, '5° grado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `idMatricula` int(11) NOT NULL,
  `idTipoMatricula` int(11) DEFAULT NULL,
  `ie_Antigua` varchar(50) DEFAULT NULL,
  `archivoDocumentacion` varchar(250) NOT NULL,
  `tipoIdentificacion` int(11) NOT NULL,
  `numeroDocumento` int(11) DEFAULT NULL,
  `nombreAlumno` varchar(100) NOT NULL,
  `apellidoAlumno` varchar(100) NOT NULL,
  `idNivel` int(11) DEFAULT NULL,
  `idGrado` int(11) DEFAULT NULL,
  `vaucher` varchar(250) NOT NULL,
  `archivoVaucher` varchar(250) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`idMatricula`, `idTipoMatricula`, `ie_Antigua`, `archivoDocumentacion`, `tipoIdentificacion`, `numeroDocumento`, `nombreAlumno`, `apellidoAlumno`, `idNivel`, `idGrado`, `vaucher`, `archivoVaucher`, `idUsuario`, `estado`) VALUES
(1, 3, '', '1701714253Copia de MATRIZ(1).pdf', 1, 1234567, 'diana', 'bocanegra', 1, 2, '', '1_ProcesoPMBOK.pdf', 2, 'Aprobado'),
(2, 3, '', '1701720021Plantilla Diagrama de Gantt.pdf', 1, 9876543, 'maria', 'contreras', 1, 3, '', '', 2, 'Expulsado'),
(3, 1, 'Cruz Saco', '1716396479COMPROBANTE (3).pdf', 1, 32125460, 'Ada Esther', 'Castillo Lon', 1, 1, '', '', 4, 'Expulsado'),
(4, 2, '', '1716397453S02_01 ETL desde un archivo Excel a SQL Server.pdf', 1, 23223332, 'retr', 'ere', 1, 3, '', '', 2, 'Expulsado'),
(5, 2, '', '1716397540Constancia_matricula.pdf', 1, 444, '23', '13', 1, 3, '', '', 2, 'Expulsado'),
(6, 3, '', '1716399892S02_01 ETL desde un archivo Excel a SQL Server.pdf', 1, 70366066, 'Anthony', 'Reyes', 1, 3, '', '', 2, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `idNivel` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`idNivel`, `descripcion`) VALUES
(1, 'Primaria'),
(2, 'Secundaria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoidentificacion`
--

CREATE TABLE `tipoidentificacion` (
  `idTipoIdentificacion` int(11) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipoidentificacion`
--

INSERT INTO `tipoidentificacion` (`idTipoIdentificacion`, `descripcion`) VALUES
(1, 'DNI'),
(2, 'PASSAPORTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomatricula`
--

CREATE TABLE `tipomatricula` (
  `idTipoMatricula` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `contenido` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipomatricula`
--

INSERT INTO `tipomatricula` (`idTipoMatricula`, `descripcion`, `contenido`) VALUES
(1, 'Traslado/Nuevo', 'Documento de constancia de vacante emitada del colegio // Documento de Traslado de matrícula // Libreta de notas o calificaciones parciales( Durante el periodo lectivo) // Certificado de Estudios (Culmina el periodo electivo) // DNI o Partida de nacimiento // Si es extranjero (Pasaporte o Documento emitido por Autoridades Migratorias)'),
(2, 'Repitente', 'Libreta de Notas // DNI o Partida de Nacimiento // Si es extranjero (Pasaporte o Documento emitido por Autoridades Migratorias)'),
(3, 'Continuidad Regular', 'Libreta de Notas // DNI o Partida de Nacimiento // Si es extranjero (Pasaporte o Documento emitido por Autoridades Migratorias)'),
(4, 'Discapacidad leve o moderada', 'Libreta de Notas // DNI o Partida de Nacimiento // Si es extranjero (Pasaporte o Documento emitido por Autoridades Migratorias) // Certificado de Discapacidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `idTipoUsuario` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`idTipoUsuario`, `descripcion`) VALUES
(1, 'Administrador'),
(2, 'Apoderado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `identificacion` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(250) NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  `contraseña` varchar(200) DEFAULT NULL,
  `idTipoUsuario` int(11) DEFAULT NULL,
  `idTipoIdentificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `identificacion`, `nombre`, `apellido`, `email`, `sexo`, `contraseña`, `idTipoUsuario`, `idTipoIdentificacion`) VALUES
(2, 4567, 'Maria', 'BOCANEGRA', 'maria@gmail.com', 'F', '123', 2, 1),
(4, 70366067, 'Abraham', 'Reyes', 'sebastian14.src@gmail.com', 'M', '70366067', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacantes`
--

CREATE TABLE `vacantes` (
  `id` int(11) NOT NULL,
  `idNivel` int(11) DEFAULT NULL,
  `idGrado` int(11) DEFAULT NULL,
  `vacantesDisponibles` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vacantes`
--

INSERT INTO `vacantes` (`id`, `idNivel`, `idGrado`, `vacantesDisponibles`) VALUES
(1, 0, 0, 0),
(5, 1, 2, 29),
(6, 1, 3, 25),
(7, 1, 4, 23),
(8, 1, 5, 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`idGrado`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`idMatricula`),
  ADD UNIQUE KEY `numeroDocumento` (`numeroDocumento`),
  ADD KEY `tipoIdentificacion` (`tipoIdentificacion`),
  ADD KEY `idNivel` (`idNivel`),
  ADD KEY `idGrado` (`idGrado`),
  ADD KEY `idTipoMatricula` (`idTipoMatricula`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`idNivel`);

--
-- Indices de la tabla `tipoidentificacion`
--
ALTER TABLE `tipoidentificacion`
  ADD PRIMARY KEY (`idTipoIdentificacion`);

--
-- Indices de la tabla `tipomatricula`
--
ALTER TABLE `tipomatricula`
  ADD PRIMARY KEY (`idTipoMatricula`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`idTipoUsuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
-- Indices de la tabla `vacantes`
--
ALTER TABLE `vacantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idNivel` (`idNivel`),
  ADD KEY `idGrado` (`idGrado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `grado`
--
ALTER TABLE `grado`
  MODIFY `idGrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `matricula`
--
ALTER TABLE `matricula`
  MODIFY `idMatricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `idNivel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipoidentificacion`
--
ALTER TABLE `tipoidentificacion`
  MODIFY `idTipoIdentificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipomatricula`
--
ALTER TABLE `tipomatricula`
  MODIFY `idTipoMatricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `idTipoUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vacantes`
--
ALTER TABLE `vacantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
