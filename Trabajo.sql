DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE CondicionMatricula CASCADE CONSTRAINTS;
DROP TABLE Grado CASCADE CONSTRAINTS;
DROP TABLE RolAdministrador CASCADE CONSTRAINTS;
DROP TABLE EstadoPago CASCADE CONSTRAINTS;
DROP TABLE TipoCurso CASCADE CONSTRAINTS;
DROP TABLE TipoSeccion CASCADE CONSTRAINTS;
DROP TABLE Dia CASCADE CONSTRAINTS;
DROP TABLE TipoMensaje CASCADE CONSTRAINTS;
DROP TABLE EstadoMensaje CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE ModalidadCiclo CASCADE CONSTRAINTS;
DROP TABLE EstadoCurso CASCADE CONSTRAINTS;
DROP TABLE Estudiante CASCADE CONSTRAINTS;
DROP TABLE Docente CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Pago CASCADE CONSTRAINTS;
DROP TABLE Mensaje CASCADE CONSTRAINTS;
DROP TABLE Ciclo CASCADE CONSTRAINTS;
DROP TABLE AdministradorMensaje CASCADE CONSTRAINTS;
DROP TABLE ProcesoMatricula CASCADE CONSTRAINTS;
DROP TABLE Curso CASCADE CONSTRAINTS;
DROP TABLE Seccion CASCADE CONSTRAINTS;
DROP TABLE HistorialMatricula CASCADE CONSTRAINTS;
DROP TABLE Matricula CASCADE CONSTRAINTS;

CREATE TABLE Usuario
(
  codUsuario CHAR(9) PRIMARY KEY NOT NULL,
  contrasena VARCHAR(30) NOT NULL,
  primerNombre VARCHAR(20) NOT NULL,
  segundoNombre VARCHAR(20),
  apellidoPaterno VARCHAR(20) NOT NULL,
  apellidoMaterno VARCHAR(20) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  correoUsuario VARCHAR(50) UNIQUE NOT NULL,
  telefonoUsuario NUMERIC(9) UNIQUE NOT NULL
);

CREATE TABLE CondicionMatricula
(
  codCondicionMatric CHAR(1) PRIMARY KEY NOT NULL,
  descripcionCondicionMatric VARCHAR(30) NOT NULL
);

CREATE TABLE Grado
(
  codGrado CHAR(1) PRIMARY KEY NOT NULL,
  descripcionGrado VARCHAR(20) NOT NULL
);

CREATE TABLE RolAdministrador
(
  codRol CHAR(1) PRIMARY KEY NOT NULL,
  descripcionRol VARCHAR(30) NOT NULL
);

CREATE TABLE EstadoPago
(
  codEstadoPago CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoPago VARCHAR(30) NOT NULL
);

CREATE TABLE TipoCurso
(
  codTipoCurso CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoCurso VARCHAR(30) NOT NULL
);

CREATE TABLE TipoSeccion
(
  codTipoSeccion CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoSeccion VARCHAR(20) NOT NULL
);

CREATE TABLE Dia
(
  codDia CHAR(1) PRIMARY KEY NOT NULL,
  nombreDia VARCHAR(20) NOT NULL
);

CREATE TABLE TipoMensaje
(
  codTipoMensaje CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoMensaje VARCHAR(100) NOT NULL
);

CREATE TABLE EstadoMensaje
(
  codEstadoMensaje CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoMensaje VARCHAR(30) NOT NULL
);

CREATE TABLE Turno
(
  codTurno CHAR(5) PRIMARY KEY NOT NULL,
  numeroTurno NUMERIC(2) NOT NULL,
  fechaTurno DATE NOT NULL,
  horaInicioTurno NUMERIC(4) NOT NULL,
  horaFinTurno NUMERIC(4) NOT NULL,
  tipoTurno CHAR(1) NOT NULL,
  FOREIGN KEY (tipoTurno) REFERENCES CondicionMatricula(codCondicionMatric)
);

CREATE TABLE ModalidadCiclo
(
  codModalidadCiclo CHAR(1) PRIMARY KEY NOT NULL,
  descripcionModalidadCiclo VARCHAR(30) NOT NULL
);

CREATE TABLE EstadoCurso
(
  codEstadoCurso CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoCurso VARCHAR(40) NOT NULL
);

CREATE TABLE Estudiante
(
  codEstudiante CHAR(9) PRIMARY KEY NOT NULL,
  especialidad CHAR(2) NOT NULL,
  cicloRelativo NUMERIC(2) NOT NULL,
  numeroCreditos NUMERIC(2) NOT NULL,
  matriculaHabilitada CHAR(1) NOT NULL,
  promedioPonderado NUMBER(5,2) NOT NULL,
  matriculaHecha CHAR(1) NOT NULL,
  codCondicionMatric CHAR(1) NOT NULL,
  codTurno CHAR(5) NOT NULL,
  FOREIGN KEY (codEstudiante) REFERENCES Usuario(codUsuario),
  FOREIGN KEY (codCondicionMatric) REFERENCES CondicionMatricula(codCondicionMatric),
  FOREIGN KEY (codTurno) REFERENCES Turno(codTurno)
);

CREATE TABLE Docente
(
  codDocente CHAR(9) PRIMARY KEY NOT NULL,
  horasAsignadas INT NOT NULL,
  codGrado CHAR(1) NOT NULL,
  FOREIGN KEY (codDocente) REFERENCES Usuario(codUsuario),
  FOREIGN KEY (codGrado) REFERENCES Grado(codGrado)
);

CREATE TABLE Administrador
(
  codAdministrador CHAR(9) PRIMARY KEY NOT NULL,
  codRol CHAR(1) NOT NULL,
  FOREIGN KEY (codAdministrador) REFERENCES Usuario(codUsuario),
  FOREIGN KEY (codRol) REFERENCES RolAdministrador(codRol)
);

CREATE TABLE Pago
(
  codPago CHAR(8) NOT NULL,
  codEstudiante CHAR(9) NOT NULL,
  entidadFinanciera VARCHAR(20) NOT NULL,
  fechaVencimiento DATE NOT NULL,
  fechaApertura DATE NOT NULL,
  fechaPago DATE,
  codEstadoPago CHAR(1) NOT NULL,
  PRIMARY KEY (codPago, codEstudiante),
  FOREIGN KEY (codEstadoPago) REFERENCES EstadoPago(codEstadoPago),
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante)
);

CREATE TABLE Mensaje
(
  codMensaje CHAR(5) PRIMARY KEY NOT NULL,
  fechaMensaje DATE NOT NULL,
  codEstudiante CHAR(9) NOT NULL,
  codTipoMensaje CHAR(1) NOT NULL,
  codEstadoMensaje CHAR(1) NOT NULL,
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codTipoMensaje) REFERENCES TipoMensaje(codTipoMensaje),
  FOREIGN KEY (codEstadoMensaje) REFERENCES EstadoMensaje(codEstadoMensaje)
);

CREATE TABLE Ciclo
(
  codCiclo CHAR(4) PRIMARY KEY NOT NULL,
  fechaInicioCiclo DATE NOT NULL,
  fechaFinCiclo DATE NOT NULL,
  codModalidadCiclo CHAR(1) NOT NULL,
  FOREIGN KEY (codModalidadCiclo) REFERENCES ModalidadCiclo(codModalidadCiclo)
);

CREATE TABLE AdministradorMensaje
(
  codAdministrador CHAR(9) NOT NULL,
  codMensaje CHAR(5) NOT NULL,
  fechaAtencion DATE NOT NULL,
  PRIMARY KEY (codAdministrador, codMensaje),
  FOREIGN KEY (codAdministrador) REFERENCES Administrador(codAdministrador),
  FOREIGN KEY (codMensaje) REFERENCES Mensaje(codMensaje)
);

CREATE TABLE ProcesoMatricula
(
  codProceso CHAR(4) PRIMARY KEY NOT NULL,
  fechaProceso DATE NOT NULL,
  horaInicioProceso NUMERIC(4) NOT NULL,
  horaFinProceso NUMERIC(4) NOT NULL,
  tipoProceso CHAR(1) NOT NULL,
  codCiclo CHAR(4) NOT NULL,
  FOREIGN KEY (tipoProceso) REFERENCES CondicionMatricula(codCondicionMatric),
  FOREIGN KEY (codCiclo) REFERENCES Ciclo(codCiclo)
);

CREATE TABLE Curso
(
  codCurso CHAR(5) PRIMARY KEY NOT NULL,
  nombreCurso VARCHAR(50) NOT NULL,
  pesoCreditos INT NOT NULL,
  codCursoPrereq1 CHAR(5),
  codCursoPrereq2 CHAR(5),
  codTipoCurso CHAR(1) NOT NULL,
  FOREIGN KEY (codCursoPrereq1) REFERENCES Curso(codCurso),
  FOREIGN KEY (codCursoPrereq2) REFERENCES Curso(codCurso),
  FOREIGN KEY (codTipoCurso) REFERENCES TipoCurso(codTipoCurso)
);

CREATE TABLE Seccion
(
  codSeccion CHAR(1) NOT NULL,
  codCurso CHAR(5) NOT NULL,
  codTipoSeccion CHAR(1) NOT NULL,
  horaInicioSeccion NUMERIC(4) NOT NULL,
  horaFinSeccion NUMERIC(4) NOT NULL,
  numVacantes NUMERIC(2) NOT NULL,
  numVacantesOcupadas INT NOT NULL,
  codAula CHAR(5) NOT NULL,
  codDia CHAR(1) NOT NULL,
  codDocente CHAR(9) NOT NULL,
  codCiclo CHAR(4) NOT NULL,
  PRIMARY KEY (codSeccion, codCurso, codTipoSeccion),
  FOREIGN KEY (codTipoSeccion) REFERENCES TipoSeccion(codTipoSeccion),
  FOREIGN KEY (codDia) REFERENCES Dia(codDia),
  FOREIGN KEY (codDocente) REFERENCES Docente(codDocente),
  FOREIGN KEY (codCurso) REFERENCES Curso(codCurso),
  FOREIGN KEY (codCiclo) REFERENCES Ciclo(codCiclo)
);

CREATE TABLE HistorialMatricula
(
  codEstudiante CHAR(9) NOT NULL,
  codCurso CHAR(5) NOT NULL,
  numeroVeces NUMERIC(1) NOT NULL,
  codEstadoCurso CHAR(1) NOT NULL,
  PRIMARY KEY (codEstudiante, codCurso),
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codCurso) REFERENCES Curso(codCurso),
  FOREIGN KEY (codEstadoCurso) REFERENCES EstadoCurso(codEstadoCurso)
);

CREATE TABLE Matricula
(
  codEstudiante CHAR(9) NOT NULL,
  codCurso CHAR(5) NOT NULL,
  codSeccion CHAR(1) NOT NULL,
  codTipoSeccion CHAR(1) NOT NULL,
  PRIMARY KEY (codEstudiante, codCurso, codSeccion),
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codCurso, codSeccion, codTipoSeccion) REFERENCES Seccion(codCurso, codSeccion, codTipoSeccion)
);

--Ingresando Usuario (Alumno)
INSERT INTO Usuario VALUES ('20212122G', 'qetuoe13579', 'Josue', 'Reymundo', 'Juarez', 'Sihuay', TO_DATE('2002-05-26', 'YYYY-MM-DD'), 'josue.juarez.s@uni.pe', 957175390);
INSERT INTO Usuario VALUES ('20202623H', 'zxasqw24680', 'María', 'Luisa', 'Gómez', 'Sánchez', TO_DATE('1998-09-15', 'YYYY-MM-DD'), 'maria.gomez.s@uni.pe', 956283749);
INSERT INTO Usuario VALUES ('20202224I', 'poiuyt35791', 'Carlos', 'Andrés', 'López', 'Rodríguez', TO_DATE('2001-12-03', 'YYYY-MM-DD'), 'carlos.lopez.r@uni.pe', 957648392);
INSERT INTO Usuario VALUES ('20212625J', 'mnbvcx46802', 'Laura', 'Isabel', 'Martínez', 'Hernández', TO_DATE('1995-07-20', 'YYYY-MM-DD'), 'laura.martinez.h@uni.pe', 958274913);
INSERT INTO Usuario VALUES ('20202326K', 'lkjhgf57913', 'Andrés', 'Miguel', 'Ramírez', 'García', TO_DATE('1999-02-10', 'YYYY-MM-DD'), 'andres.ramirez.g@uni.pe', 957461829);
INSERT INTO Usuario VALUES ('20212927L', 'rewqas68024', 'Ana', 'Paula', 'Pérez', 'Fernández', TO_DATE('2000-11-28', 'YYYY-MM-DD'), 'ana.perez.f@uni.pe', 956173428);

--Ingresando Usuario (Administrador)
INSERT INTO Usuario VALUES ('20062072M', 'asdjkl123', 'Pedro', 'Alberto', 'Linares', 'Reynoso', TO_DATE('2001-03-24', 'YYYY-MM-DD'), 'pedro.linares.r@uni.pe', 994578721);
INSERT INTO Usuario VALUES ('20182073N', 'qwehjk456', 'Sofía', 'Valentina', 'Herrera', 'Guzmán', TO_DATE('1997-08-12', 'YYYY-MM-DD'), 'sofia.herrera.g@uni.pe', 987654321);
INSERT INTO Usuario VALUES ('20102074O', 'zxcvbn789', 'Juan', 'Gabriel', 'Soto', 'Vargas', TO_DATE('1994-11-02', 'YYYY-MM-DD'), 'juan.soto.v@uni.pe', 986543210);
INSERT INTO Usuario VALUES ('20172075P', 'mnbvcxqwe', 'Isabella', 'Fernanda', 'Gutiérrez', 'Mendoza', TO_DATE('1998-05-17', 'YYYY-MM-DD'), 'isabella.gutierrez.m@uni.pe', 978654321);
INSERT INTO Usuario VALUES ('20192076Q', 'lkjhgfdsa', 'Diego', 'Sebastián', 'Cabrera', 'Ortega', TO_DATE('2000-01-08', 'YYYY-MM-DD'), 'diego.cabrera.o@uni.pe', 965432178);
INSERT INTO Usuario VALUES ('20145678X', 'abhcd1234', 'Carlos', 'Alberto', 'Ramírez', 'López', TO_DATE('1999-09-30', 'YYYY-MM-DD'), 'carlos.ramirez.l@uni.pe', 987353421);

--Ingresado Usuario (Docente)
--Docentes de Geometría Analítica
INSERT INTO Usuario VALUES ('19908019J', 'zxdryt742', 'Pedro', 'Raul', 'Acosta', 'De La Cruz', TO_DATE('1974-05-03', 'YYYY-MM-DD'), 'pracostad@uni.edu.pe', 924678135);
INSERT INTO Usuario VALUES ('19888841A', 'bnjhty963', 'Riquelmer', 'Apolinario', 'Vasquez', 'Dominguez', TO_DATE('1974-08-15', 'YYYY-MM-DD'), 'ravasquezd@uni.edu.pe', 932468175);
INSERT INTO Usuario VALUES ('19906742B', 'mkiolp841', 'Miguel', NULL, 'Cutipa', 'Coaquira', TO_DATE('1972-11-19', 'YYYY-MM-DD'), 'micutipac@uni.edu.pe', 945674312);
INSERT INTO Usuario VALUES ('19958130A', 'plknbv741', 'Ricardo', 'Alejandro', 'Chung', 'Ching', TO_DATE('1970-04-18', 'YYYY-MM-DD'), 'rachungc@uni.edu.pe', 956342187);
INSERT INTO Usuario VALUES ('19728422K', 'qazwsx963', 'Lourdes', 'Cristina', 'Kala', 'Béjar', TO_DATE('1968-05-16', 'YYYY-MM-DD'), 'lckalab@uni.edu.pe', 964817523);
--Docentes de Cálculo Diferencial
INSERT INTO Usuario VALUES ('20128061K', 'xyasfd524', 'Alexander', 'Abel', 'Bonifacio', 'Castro', TO_DATE('1973-03-24', 'YYYY-MM-DD'), 'aabonifacioc@uni.edu.pe', 913456789);
INSERT INTO Usuario VALUES ('19918501I', 'vcxzlk741', 'Victor', 'José', 'Moncada', 'Béjar', TO_DATE('1970-03-27', 'YYYY-MM-DD'), 'vjmoncadab@uni.edu.pe', 978654320);
INSERT INTO Usuario VALUES ('19928251E', 'qweasd852', 'Javier', 'Francisco', 'Echenadia', 'Cespedes', TO_DATE('1970-06-12', 'YYYY-MM-DD'), 'jfechenadiac@uni.edu.pe', 984217536);
INSERT INTO Usuario VALUES ('19903756G', 'xswedc963', 'Osmar', 'Arnaldo', 'Bermeo', 'Carrasco', TO_DATE('1973-08-04', 'YYYY-MM-DD'), 'oabermeoc@uni.edu.pe', 991238457);
--Docentes de Quimica 1
INSERT INTO Usuario VALUES ('19828006I', 'nbvcxz741', 'Daniel', 'Adolfo', 'Alcantara', 'Malca', TO_DATE('1968-12-19', 'YYYY-MM-DD'), 'daalcantaram@uni.edu.pe', 905678124);
INSERT INTO Usuario VALUES ('19948273D', 'lkjhgf852', 'Nancy', 'Elena', 'Fukuda', 'Kagami', TO_DATE('1971-02-07', 'YYYY-MM-DD'), 'nefukudak@uni.edu.pe', 916542387);
INSERT INTO Usuario VALUES ('19938129H', 'poiuyt963', 'Carlos', 'Alberto', 'Chafloque', 'Elias', TO_DATE('1966-09-23', 'YYYY-MM-DD'), 'cachafloquee@uni.edu.pe', 929674513);
--Docentes de Economía General
INSERT INTO Usuario VALUES ('19928504K', 'asdfgh741', 'Cesar', 'Aurelio', 'Miranda', 'Torres', TO_DATE('1974-05-15', 'YYYY-MM-DD'), 'camirandat@uni.edu.pe', 938475621);
INSERT INTO Usuario VALUES ('19868642C', 'qwerty852', 'Silvio', NULL, 'Quinteros', 'Chavez', TO_DATE('1969-11-30', 'YYYY-MM-DD'), 'siquinterosc@uni.edu.pe', 948562173);
INSERT INTO Usuario VALUES ('19728525D', 'zxcvbn963', 'Margarita', 'Delicia', 'Mondragón', 'Hernández', TO_DATE('1972-03-27', 'YYYY-MM-DD'), 'mdmondragonh@uni.edu.pe', 957348216);
--Docentes de Matemática Aplicada
INSERT INTO Usuario VALUES ('19758129J', 'rtyuio741', 'Eddie', 'Danny', 'Cueva', 'Huanuco', TO_DATE('1975-01-09', 'YYYY-MM-DD'), 'edcuevah@uni.edu.pe', 966321847);
INSERT INTO Usuario VALUES ('19908764G', 'sdfghj852', 'Paul', 'Miller', 'Tocto', 'Inga', TO_DATE('1967-07-26', 'YYYY-MM-DD'), 'pmtoctoi@uni.edu.pe', 971852643);
--Docentes de Teoría Organizacional
INSERT INTO Usuario VALUES ('19868669I', 'mnbvcx963', 'Doris', 'Fanny', 'Rojas', 'Mendoza', TO_DATE('1970-10-18', 'YYYY-MM-DD'), 'dfrojasm@uni.edu.pe', 986124537);
INSERT INTO Usuario VALUES ('19958351H', 'lkjhgd741', 'Eliana', 'Cecilia', 'Rizabal', 'Flores', TO_DATE('1968-04-04', 'YYYY-MM-DD'), 'ecrizabalf@uni.edu.pe', 994563218);
--Docentes de Investigación de Operaciones 1
INSERT INTO Usuario VALUES ('19988122G', 'jhgfda852', 'Cesar', 'Aldo', 'Canelo', 'Sotelo', TO_DATE('1973-06-27', 'YYYY-MM-DD'), 'cacanelos@uni.edu.pe', 909871325);
INSERT INTO Usuario VALUES ('20038504K', 'qwertf963', 'Luis', 'Felipe', 'Medina', 'Aquino', TO_DATE('1971-09-08', 'YYYY-MM-DD'), 'lfmedinaa@uni.edu.pe', 912835476);
INSERT INTO Usuario VALUES ('19798272H', 'zxcvbm741', 'Cesar', 'Antonio', 'Fernandez', 'Lostanau', TO_DATE('1966-11-21', 'YYYY-MM-DD'), 'cafernandezl@uni.edu.pe', 926543817);
--Docentes de Ingeniería de Procesos
INSERT INTO Usuario VALUES ('20078352G', 'poiuyr852', 'Alejandrina', 'Nelly', 'Huarcaya', 'Junes', TO_DATE('1974-03-13', 'YYYY-MM-DD'), 'anhuarcayaj@uni.edu.pe', 931276548);
INSERT INTO Usuario VALUES ('19978303I', 'nmnbvc963', 'Julio', 'Cesar', 'Talaverano', 'Garcia', TO_DATE('1969-05-02', 'YYYY-MM-DD'), 'jctalaveranog@uni.edu.pe', 949312876);
--Docentes de Diseño de Base de Datos
INSERT INTO Usuario VALUES ('19828668A', 'iuytrw852', 'Tino', 'Eduardo', 'Reyna', 'Monteverde', TO_DATE('1975-04-16', 'YYYY-MM-DD'), 'tereynam@uni.edu.pe', 967483215);
INSERT INTO Usuario VALUES ('19858136H', 'qazxcv963', 'Jose', 'Alberto', 'Caballero', 'Torres', TO_DATE('1967-12-01', 'YYYY-MM-DD'), 'jacaballerot@uni.edu.pe', 972635184);
--Docentes de Dinámica de Sistemas
INSERT INTO Usuario VALUES ('19808513B', 'zxasqw741', 'Celedonio', NULL, 'Méndez', 'Valdivia', TO_DATE('1970-02-21', 'YYYY-MM-DD'), 'cemendezv@uni.edu.pe', 985647219);
INSERT INTO Usuario VALUES ('20018441C', 'cvbjhg841', 'Jorge', 'Daniel', 'Llanos', 'Panduro', TO_DATE('1960-05-13', 'YYYY-MM-DD'), 'jdllanosp@uni.edu.pe', 967264124);

INSERT INTO CondicionMatricula VALUES ('1', 'Promocion');
INSERT INTO CondicionMatricula VALUES ('2', 'Regular');
INSERT INTO CondicionMatricula VALUES ('3', 'En riesgo');
INSERT INTO CondicionMatricula VALUES ('4', 'Reintegrado');
INSERT INTO CondicionMatricula VALUES ('5', 'Rezagado');

INSERT INTO Grado VALUES ('1', 'Bachillerato');
INSERT INTO Grado VALUES ('2', 'Licenciatura');
INSERT INTO Grado VALUES ('3', 'Maestría');
INSERT INTO Grado VALUES ('4', 'Especialidad');
INSERT INTO Grado VALUES ('5', 'Doctorado');

INSERT INTO RolAdministrador VALUES ('1', 'Comision de Matricula');
INSERT INTO RolAdministrador VALUES ('2', 'TEFIIS');
INSERT INTO RolAdministrador VALUES ('3', 'Director de Escuela');
INSERT INTO RolAdministrador VALUES ('4', 'Oficina de Estadística');

INSERT INTO EstadoPago VALUES ('1', 'Pago realizado');
INSERT INTO EstadoPago VALUES ('2', 'Pago pendiente');
INSERT INTO EstadoPago VALUES ('3', 'Pago en proceso');
INSERT INTO EstadoPago VALUES ('4', 'Pago rechazado');

INSERT INTO TipoCurso VALUES ('A', 'Curso electivo');
INSERT INTO TipoCurso VALUES ('B', 'Curso de carrera');
INSERT INTO TipoCurso VALUES ('C', 'Curso general');

INSERT INTO TipoSeccion VALUES ('T', 'Teoría');
INSERT INTO TipoSeccion VALUES ('P', 'Práctica');
INSERT INTO TipoSeccion VALUES ('L', 'Laboratorio');

INSERT INTO Dia VALUES ('L', 'Lunes');
INSERT INTO Dia VALUES ('M', 'Martes'); 
INSERT INTO Dia VALUES ('X', 'Miercoles');
INSERT INTO Dia VALUES ('J', 'Jueves');
INSERT INTO Dia VALUES ('V', 'Viernes');
INSERT INTO Dia VALUES ('S', 'Sabado');

INSERT INTO TipoMensaje VALUES ('A', 'Problema con la carga horaria y de programación de horarios');
INSERT INTO TipoMensaje VALUES ('B', 'Problema por el número de vacantes disponibles');
INSERT INTO TipoMensaje VALUES ('C', 'Problema con la matrícula de un curso');
INSERT INTO TipoMensaje VALUES ('D', 'Problemas técnicos y de la plataforma para la matrícula');
INSERT INTO TipoMensaje VALUES ('E', 'Problemas con la ficha de matrícula (Cruces)');

INSERT INTO EstadoMensaje VALUES ('S', 'Sin atender');
INSERT INTO EstadoMensaje VALUES ('P', 'En proceso de solución');
INSERT INTO EstadoMensaje VALUES ('A', 'Atendido y solucionado');

INSERT INTO Turno VALUES ('T0000', '0', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 0800, 0900, '1');
INSERT INTO Turno VALUES ('T000R', '0', TO_DATE('2023-03-21', 'YYYY-MM-DD'), 0800, 0900, '3');
INSERT INTO Turno VALUES ('T0001', '1', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 0800, 0900, '2');
INSERT INTO Turno VALUES ('T0002', '2', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 0930, 1030, '2');
INSERT INTO Turno VALUES ('T0003', '3', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1000, 1100, '2');
INSERT INTO Turno VALUES ('T0004', '4', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1130, 1230, '2');
INSERT INTO Turno VALUES ('T0005', '5', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1200, 1300, '2');
INSERT INTO Turno VALUES ('T0006', '6', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1330, 1430, '2');
INSERT INTO Turno VALUES ('T0007', '7', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1400, 1500, '2');
INSERT INTO Turno VALUES ('T0008', '8', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1530, 1630, '2');
INSERT INTO Turno VALUES ('T0009', '9', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1600, 1700, '2');
INSERT INTO Turno VALUES ('T0010', '10', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1730, 1830, '2');
INSERT INTO Turno VALUES ('T0011', '11', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1800, 1900, '2');
INSERT INTO Turno VALUES ('T0012', '12', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1930, 2030, '2');
INSERT INTO Turno VALUES ('T0013', '13', TO_DATE('2023-03-23', 'YYYY-MM-DD'), 1400, 1500, '5');

INSERT INTO ModalidadCiclo VALUES ('P', 'Presencial');
INSERT INTO ModalidadCiclo VALUES ('V', 'Virtual');
INSERT INTO ModalidadCiclo VALUES ('H', 'Hibrido');

INSERT INTO EstadoCurso VALUES ('A', 'Curso Regular');
INSERT INTO EstadoCurso VALUES ('B', 'Curso Regular Aprobado');
INSERT INTO EstadoCurso VALUES ('C', 'Curso Regular Desaprobado');
INSERT INTO EstadoCurso VALUES ('D', 'Curso Electivo');
INSERT INTO EstadoCurso VALUES ('E', 'Curso Electivo Aprobado');
INSERT INTO EstadoCurso VALUES ('F', 'Curso Electivo Desaprobado');

INSERT INTO Estudiante VALUES ('20212122G', 'I2', 4, 43, '1', 14.57 , '0', '2', 'T0003');
INSERT INTO Estudiante VALUES ('20202623H', 'I2', 3, 34, '1', 13.46, '0', '2', 'T0005');
INSERT INTO Estudiante VALUES ('20202224I', 'I2', 5, 52, '0', 13.96, '0', '2', 'T0004');
INSERT INTO Estudiante VALUES ('20212625J', 'I1', 2, 26, '1', 11.34, '0', '3', 'T000R');
INSERT INTO Estudiante VALUES ('20202326K', 'I1', 3, 30, '1', 12.50, '0', '2', 'T0008');
INSERT INTO Estudiante VALUES ('20212927L', 'I1', 4, 41, '1', 13.53, '0', '2', 'T0004');

INSERT INTO Docente VALUES ('20018441C', 12, '4');
INSERT INTO Docente VALUES ('19908019J', 14, '5');
INSERT INTO Docente VALUES ('19888841A', 12, '4');
INSERT INTO Docente VALUES ('19906742B', 10, '4');
INSERT INTO Docente VALUES ('19958130A', 12, '4');
INSERT INTO Docente VALUES ('19728422K', 12, '4');
INSERT INTO Docente VALUES ('20128061K', 12, '5');
INSERT INTO Docente VALUES ('19918501I', 10, '5');
INSERT INTO Docente VALUES ('19928251E', 14, '5');
INSERT INTO Docente VALUES ('19903756G', 12, '4');
INSERT INTO Docente VALUES ('19828006I', 10, '5');
INSERT INTO Docente VALUES ('19928504K', 14, '4');
INSERT INTO Docente VALUES ('19868642C', 10, '4');
INSERT INTO Docente VALUES ('19728525D', 12, '5');
INSERT INTO Docente VALUES ('19758129J', 12, '4');
INSERT INTO Docente VALUES ('19908764G', 12, '4');
INSERT INTO Docente VALUES ('19868669I', 12, '4');
INSERT INTO Docente VALUES ('19958351H', 12, '4');
INSERT INTO Docente VALUES ('19988122G', 12, '4');
INSERT INTO Docente VALUES ('20038504K', 12, '4');
INSERT INTO Docente VALUES ('19798272H', 12, '4');
INSERT INTO Docente VALUES ('20078352G', 12, '4');
INSERT INTO Docente VALUES ('19978303I', 10, '4');
INSERT INTO Docente VALUES ('19828668A', 12, '4');
INSERT INTO Docente VALUES ('19858136H', 12, '4');
INSERT INTO Docente VALUES ('19808513B', 12, '4');

INSERT INTO Administrador VALUES ('20062072M', '2');
INSERT INTO Administrador VALUES ('20182073N', '2');
INSERT INTO Administrador VALUES ('20102074O', '1');
INSERT INTO Administrador VALUES ('20172075P', '1');
INSERT INTO Administrador VALUES ('20192076Q', '3');
INSERT INTO Administrador VALUES ('20145678X', '4');

INSERT INTO Pago VALUES ('46552296', '20212122G', 'Scotiabank', TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2023-01-26', 'YYYY-MM-DD'), TO_DATE('2023-02-14', 'YYYY-MM-DD'), '1');

INSERT INTO Mensaje VALUES ('M0001', TO_DATE('2023-03-22', 'YYYY-MM-DD'), '20212122G', 'B', 'P');

INSERT INTO Ciclo VALUES ('23-1', TO_DATE('2023-04-02', 'YYYY-MM-DD'), TO_DATE('2023-07-27', 'YYYY-MM-DD'), 'P');

INSERT INTO AdministradorMensaje VALUES ('20062072M', 'M0001', TO_DATE('2023-03-22', 'YYYY-MM-DD'));

INSERT INTO ProcesoMatricula VALUES ('P001', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1015, 1120, '2', '23-1');


INSERT INTO Curso VALUES ('FB101', 'GEOMETRIA ANALITICA', 3, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('BMA01', 'CALCULO DIFERENCIAL', 5, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('BQU01', 'QUIMICA 1', 5, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('BIC01', 'INTRODUCCION A LA COMPUTACION', 2, NULL, NULL, 'B');
INSERT INTO Curso VALUES ('BRC01', 'REDACCION Y COMUNICACION', 2, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('SI101', 'INTRODUCCION A LA INGENIERIA DE SISTEMAS', 3, NULL, NULL, 'B');
INSERT INTO Curso VALUES ('TE101', 'DIBUJO DE INGENIERÍA', 2, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('GE101', 'INTRODUCCIÓN A INGENIERÍA INDUSTRIAL', 3, NULL, NULL, 'B');

INSERT INTO Curso VALUES ('BEF01', 'ETICA Y FILOSOFIA POLITICA', 2, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('BMA02', 'CALCULO INTEGRAL', 5, 'BMA01', NULL, 'C');
INSERT INTO Curso VALUES ('BMA03', 'ALGEBRA LINEAL', 4, 'FB101', NULL, 'C');
INSERT INTO Curso VALUES ('SI201', 'PSICOLOGIA SISTEMICA', 3, 'SI101', NULL, 'B');
INSERT INTO Curso VALUES ('SI203', 'TEORIA Y CIENCIA DE SISTEMAS', 3, 'SI101', NULL, 'B');
INSERT INTO Curso VALUES ('SI205', 'ALGORITMIA Y ESTRUCTURA DE DATOS', 3, 'BIC01', NULL, 'B');
INSERT INTO Curso VALUES ('SI207', 'SISTEMAS BIOLOGICOS Y ECOLOGICOS', 2, 'BMA01', NULL, 'C');
INSERT INTO Curso VALUES ('SI204', 'TEORÍA GENERAL DE SISTEMAS', 2, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('FB202', 'QUIMICA 2', 4, 'BQU01', NULL, 'C');

INSERT INTO Curso VALUES ('BFI01', 'FISICA 1', 5, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('FB301', 'MATEMATICA DISCRETA', 3, 'BMA03', NULL, 'C');
INSERT INTO Curso VALUES ('FB303', 'CALCULO MULTIVARIABLE', 5, 'BMA02', 'BMA03', 'C');
INSERT INTO Curso VALUES ('FB305', 'ESTADISTICA Y PROBABILIDADES', 2, 'BMA02', NULL, 'C');
INSERT INTO Curso VALUES ('HU301', 'METODOLOGIA DE LA INVESTIGACION', 2, 'BRC01', 'SI203', 'B');
INSERT INTO Curso VALUES ('SI301', 'TEORIA Y CIENCIA DE SISTEMAS APLICADA', 2, 'SI201', 'SI203', 'B');
INSERT INTO Curso VALUES ('SI302', 'PROGRAMACIÓN ORIENTADA A OBJETOS', 3, 'SI205', NULL, 'B');
INSERT INTO Curso VALUES ('TE302', 'DISEÑO ASISTIDO POR COMPUTADORA', 3, 'TE101', NULL, 'B');
INSERT INTO Curso VALUES ('TE301', 'FÍSICO QUÍMICA Y OPERACIONES UNITARIAS', 4, 'FB202', NULL, 'B');

INSERT INTO Curso VALUES ('FB401', 'FISICA 2', 5, 'BFI01', NULL, 'C');
INSERT INTO Curso VALUES ('FB402', 'CALCULO NUMERICO', 3, 'FB301', NULL, 'C');
INSERT INTO Curso VALUES ('FB403', 'ECUACIONES DIFERENCIALES', 5, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('FB405', 'ESTADISTICA APLICADA', 3, 'FB305', NULL, 'C');
INSERT INTO Curso VALUES ('HU102', 'DESARROLLO PERSONAL', 2, 'BEF01', NULL, 'C');
INSERT INTO Curso VALUES ('SI403', 'METODOLOGIA DE LOS SISTEMAS BLANDOS', 3, 'HU301', 'SI301', 'B');
INSERT INTO Curso VALUES ('SI405', 'MODELADO CONCEPTUAL DE DATOS', 3, 'SI302', NULL, 'B');
INSERT INTO Curso VALUES ('SI401', 'LENGUAJE DE PROGRAMACIÓN', 3, 'FB301', NULL, 'B');
INSERT INTO Curso VALUES ('TE401', 'TERMODINÁMICA', 3, 'TE301', 'BFI01', 'B');

INSERT INTO Curso VALUES ('BEG01', 'ECONOMIA GENERAL', 3, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('BRN01', 'REALIDAD NACIONAL, CONSTITUCION Y DERECHOS HUMANOS', 3, NULL, NULL, 'C');
INSERT INTO Curso VALUES ('FB501', 'MATEMATICA APLICADA', 3, 'FB402', NULL, 'C');
INSERT INTO Curso VALUES ('GE501', 'TEORIA ORGANIZACIONAL', 3, 'FB405', 'SI207', 'C');
INSERT INTO Curso VALUES ('SI501', 'INVESTIGACION DE OPERACIONES 1', 3, 'FB405', NULL, 'C');
INSERT INTO Curso VALUES ('SI503', 'INGENIERIA DE PROCESOS', 3, 'SI301', NULL, 'B');
INSERT INTO Curso VALUES ('SI505', 'DISEÑO DE BASE DE DATOS', 3, 'SI405', NULL, 'B');
INSERT INTO Curso VALUES ('HU201', 'SOCIOLOGÍA', 2, 'BEG01', 'SI204', 'B');
INSERT INTO Curso VALUES ('TE502', 'RESISTENCIA DE MATERIALES', 3, 'FB401', NULL, 'C');
INSERT INTO Curso VALUES ('TE503', 'PROCESOS INDUSTRIALES 1', 4, 'TE401', NULL, 'C');
INSERT INTO Curso VALUES ('TE501', 'ELECTRICIDAD Y ELECTRÓNICA INDUSTRIAL', 4, 'FB401', NULL, 'C');
INSERT INTO Curso VALUES ('GE502', 'INGENIERÍA DEL TRABAJO 1', 3, 'GE101', NULL, 'C');

INSERT INTO Curso VALUES ('SI602', 'DINÁMICA DE SISTEMAS', 3, 'FB403', NULL, 'B');

--Secciones de Geometría Analítica
INSERT INTO Seccion VALUES ('U', 'FB101', 'T', 0800, 1000, 28, 35, 'S4212', 'X', '19908019J', '23-1');
INSERT INTO Seccion VALUES ('U', 'FB101', 'P', 1000, 1200, 28, 35, 'S4212', 'V', '19908019J', '23-1');
INSERT INTO Seccion VALUES ('V', 'FB101', 'T', 1000, 1200, 24, 35, 'S4216', 'X', '19888841A', '23-1');
INSERT INTO Seccion VALUES ('V', 'FB101', 'P', 1000, 1200, 24, 35, 'S4216', 'V', '19888841A', '23-1');
INSERT INTO Seccion VALUES ('W', 'FB101', 'T', 1000, 1200, 26, 35, 'S4212', 'X', '19908019J', '23-1');
INSERT INTO Seccion VALUES ('W', 'FB101', 'P', 1000, 1200, 26, 35, 'S4105', 'V', '19906742B', '23-1');
INSERT INTO Seccion VALUES ('Y', 'FB101', 'T', 1000, 1200, 22, 35, 'S4202', 'X', '19958130A', '23-1');
INSERT INTO Seccion VALUES ('Y', 'FB101', 'P', 1000, 1200, 22, 35, 'S4201', 'V', '19728422K', '23-1');
--Secciones de Calculo Diferencial
INSERT INTO Seccion VALUES ('V', 'BMA01', 'T', 1400, 1600, 20, 40, 'S4216', 'M', '19888841A', '23-1');
INSERT INTO Seccion VALUES ('V', 'BMA01', 'P', 1200, 1400, 20, 40, 'S4208', 'X', '19928251E', '23-1');
INSERT INTO Seccion VALUES ('V', 'BMA01', 'T', 1600, 1800, 20, 40, 'S4210', 'V', '19888841A', '23-1');
INSERT INTO Seccion VALUES ('X', 'BMA01', 'T', 0800, 1000, 25, 40, 'S4206', 'L', '19903756G', '23-1');
INSERT INTO Seccion VALUES ('X', 'BMA01', 'P', 1200, 1400, 25, 40, 'S4206', 'X', '19903756G', '23-1');
INSERT INTO Seccion VALUES ('X', 'BMA01', 'T', 0800, 1000, 25, 40, 'S4206', 'V', '19903756G', '23-1');
INSERT INTO Seccion VALUES ('Z', 'BMA01', 'T', 1400, 1600, 23, 40, 'S4205', 'J', '19918501I', '23-1');
INSERT INTO Seccion VALUES ('Z', 'BMA01', 'T', 1400, 1600, 23, 40, 'S4204', 'L', '19918501I', '23-1');
INSERT INTO Seccion VALUES ('Z', 'BMA01', 'P', 1200, 1400, 23, 40, 'S4201', 'X', '20128061K', '23-1');
--Secciones de Quimica 1

--Secciones de Economía General
INSERT INTO Seccion VALUES ('U', 'BEG01', 'T', 0800, 1000, 23, 35, 'S4205', 'L', '19868642C', '23-1');
INSERT INTO Seccion VALUES ('U', 'BEG01', 'P', 0800, 1000, 23, 35, 'S4205', 'X', '19868642C', '23-1');
INSERT INTO Seccion VALUES ('V', 'BEG01', 'P', 1000, 1200, 25, 35, 'S4210', 'J', '19928504K', '23-1');
INSERT INTO Seccion VALUES ('V', 'BEG01', 'T', 1000, 1200, 25, 35, 'S4210', 'M', '19928504K', '23-1');
INSERT INTO Seccion VALUES ('W', 'BEG01', 'P', 1400, 1600, 21, 35, 'S4201', 'J', '19728525D', '23-1');
INSERT INTO Seccion VALUES ('W', 'BEG01', 'T', 1400, 1600, 21, 35, 'S4201', 'X', '19728525D', '23-1');
INSERT INTO Seccion VALUES ('X', 'BEG01', 'P', 1400, 1600, 26, 35, 'S4210', 'J', '19928504K', '23-1');
INSERT INTO Seccion VALUES ('X', 'BEG01', 'T', 1400, 1600, 26, 35, 'S4210', 'M', '19928504K', '23-1');
--Secciones de Matemática Aplicada
INSERT INTO Seccion VALUES ('U', 'FB501', 'P', 0800, 1000, 23, 35, 'S4208', 'X', '19908764G', '23-1');
INSERT INTO Seccion VALUES ('U', 'FB501', 'T', 1000, 1200, 23, 35, 'S4209', 'X', '19908764G', '23-1');
INSERT INTO Seccion VALUES ('V', 'FB501', 'P', 0800, 1000, 19, 35, 'S4202', 'X', '19758129J', '23-1');
INSERT INTO Seccion VALUES ('V', 'FB501', 'T', 0800, 1000, 19, 35, 'S4202', 'S', '19758129J', '23-1');
--Secciones de Teoría Organizacional
INSERT INTO Seccion VALUES ('U', 'GE501', 'P', 1400, 1600, 14, 25, 'S4109', 'J', '19868669I', '23-1');
INSERT INTO Seccion VALUES ('U', 'GE501', 'T', 1400, 1600, 14, 25, 'S4109', 'M', '19868669I', '23-1');
INSERT INTO Seccion VALUES ('V', 'GE501', 'T', 1800, 2000, 18, 25, 'S4216', 'M', '19958351H', '23-1');
INSERT INTO Seccion VALUES ('V', 'GE501', 'P', 2000, 2200, 18, 25, 'S4216', 'M', '19958351H', '23-1');
--Secciones de IO1
INSERT INTO Seccion VALUES ('U', 'SI501', 'T', 1600, 1800, 32, 40, 'S4206', 'M', '19988122G', '23-1');
INSERT INTO Seccion VALUES ('U', 'SI501', 'P', 2000, 2200, 32, 40, 'S4206', 'M', '19988122G', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI501', 'T', 1600, 1800, 28, 40, 'S4201', 'M', '20038504K', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI501', 'P', 1400, 1600, 28, 40, 'S4201', 'V', '19798272H', '23-1');
INSERT INTO Seccion VALUES ('X', 'SI501', 'T', 1600, 1800, 30, 40, 'S4211', 'J', '20038504K', '23-1');
INSERT INTO Seccion VALUES ('X', 'SI501', 'P', 1200, 1400, 30, 40, 'S4210', 'V', '19798272H', '23-1');
--Secciones de Ingeniería de Procesos
INSERT INTO Seccion VALUES ('U', 'SI503', 'T', 1000, 1200, 26, 35, 'LAB-O', 'L', '20078352G', '23-1');
INSERT INTO Seccion VALUES ('U', 'SI503', 'P', 1200, 1400, 26, 35, 'LAB-O', 'L', '20078352G', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI503', 'T', 1800, 2000, 28, 35, 'S4213', 'X', '19958351H', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI503', 'P', 2000, 2200, 28, 35, 'S4213', 'X', '19958351H', '23-1');
INSERT INTO Seccion VALUES ('W', 'SI503', 'P', 2000, 2200, 22, 35, 'S4205', 'J', '19978303I', '23-1');
INSERT INTO Seccion VALUES ('W', 'SI503', 'T', 2000, 2200, 22, 35, 'S4210', 'M', '19978303I', '23-1');
--Secciones de Diseño de Base de Datos
INSERT INTO Seccion VALUES ('U', 'SI505', 'T', 0900, 1100, 23, 31, 'S4213', 'S', '19828668A', '23-1');
INSERT INTO Seccion VALUES ('U', 'SI505', 'P', 1100, 1300, 23, 31, 'S4213', 'S', '19828668A', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI505', 'T', 1800, 2000, 27, 31, 'LAB-A', 'L', '19858136H', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI505', 'P', 2000, 2200, 27, 31, 'LAB-A', 'L', '19858136H', '23-1');
--Secciones de Dinámica de Sistemas
INSERT INTO Seccion VALUES ('U', 'SI602', 'T', 1800, 2000, 25, 29, 'LAB-C', 'L', '19808513B', '23-1');
INSERT INTO Seccion VALUES ('U', 'SI602', 'P', 2000, 2200, 25, 29, 'LAB-C', 'L', '19808513B', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI602', 'T', 1800, 2000, 22, 29, 'S4140', 'X', '20018441C', '23-1');
INSERT INTO Seccion VALUES ('V', 'SI602', 'P', 2000, 2200, 22, 29, 'S4140', 'X', '20018441C', '23-1');

INSERT INTO HistorialMatricula VALUES ('20212122G', 'FB101', 1, 'B');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'BEG01', 1, 'C');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'FB501', 0, 'A');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'GE501', 0, 'A');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'SI501', 0, 'A');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'SI503', 0, 'A');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'SI505', 0, 'A');
INSERT INTO HistorialMatricula VALUES ('20212122G', 'SI602', 0, 'A');

--INSERT INTO Matricula VALUES ('20212122G', 'BIC01', 'V', 'L');

SELECT * FROM Usuario;
SELECT * FROM CondicionMatricula;
SELECT * FROM Grado;
SELECT * FROM RolAdministrador;
SELECT * FROM EstadoPago;
SELECT * FROM TipoCurso;
SELECT * FROM TipoSeccion;
SELECT * FROM Dia;
SELECT * FROM TipoMensaje;
SELECT * FROM EstadoMensaje;
SELECT * FROM Turno;
SELECT * FROM ModalidadCiclo;
SELECT * FROM EstadoCurso;
SELECT * FROM Estudiante;
SELECT * FROM Docente;
SELECT * FROM Administrador;
SELECT * FROM Pago;
SELECT * FROM Mensaje;
SELECT * FROM Ciclo;
SELECT * FROM AdministradorMensaje;
SELECT * FROM Curso;
SELECT * FROM Seccion;
SELECT * FROM HistorialMatricula;
