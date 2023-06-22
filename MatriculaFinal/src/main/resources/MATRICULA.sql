CREATE TABLE Usuario(
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

CREATE TABLE CondicionMatricula(
  codCondicionMatric CHAR(1) PRIMARY KEY NOT NULL,
  descripcionCondicionMatric VARCHAR(30) NOT NULL
);

CREATE TABLE Grado(
  codGrado CHAR(1) PRIMARY KEY NOT NULL,
  descripcionGrado VARCHAR(20) NOT NULL
);

CREATE TABLE RolAdministrador(
  codRol CHAR(1) PRIMARY KEY NOT NULL,
  descripcionRol VARCHAR(30) NOT NULL
);

CREATE TABLE EstadoPago(
  codEstadoPago CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoPago VARCHAR(30) NOT NULL
);

CREATE TABLE TipoCurso(
  codTipoCurso CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoCurso VARCHAR(30) NOT NULL
);

CREATE TABLE TipoSeccion(
  codTipoSeccion CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoSeccion VARCHAR(20) NOT NULL
);

CREATE TABLE Dia(
  codDia CHAR(1) PRIMARY KEY NOT NULL,
  nombreDia VARCHAR(20) NOT NULL
);

CREATE TABLE TipoMensaje(
  codTipoMensaje CHAR(1) PRIMARY KEY NOT NULL,
  descripcionTipoMensaje VARCHAR(100) NOT NULL
);

CREATE TABLE EstadoMensaje(
  codEstadoMensaje CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoMensaje VARCHAR(30) NOT NULL
);

CREATE TABLE Turno(
  codTurno CHAR(5) PRIMARY KEY NOT NULL,
  numeroTurno NUMERIC(2) NOT NULL,
  fechaTurno DATE NOT NULL,
  horaInicioTurno NUMERIC(4) NOT NULL,
  horaFinTurno NUMERIC(4) NOT NULL,
  tipoTurno CHAR(1) NOT NULL,
  FOREIGN KEY (tipoTurno) REFERENCES CondicionMatricula(codCondicionMatric)
);

CREATE TABLE ModalidadCiclo(
  codModalidadCiclo CHAR(1) PRIMARY KEY NOT NULL,
  descripcionModalidadCiclo VARCHAR(30) NOT NULL
);

CREATE TABLE EstadoCurso(
  codEstadoCurso CHAR(1) PRIMARY KEY NOT NULL,
  descripcionEstadoCurso VARCHAR(40) NOT NULL
);

CREATE TABLE Estudiante(
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

CREATE TABLE Docente(
  codDocente CHAR(9) PRIMARY KEY NOT NULL,
  horasAsignadas INT NOT NULL,
  codGrado CHAR(1) NOT NULL,
  FOREIGN KEY (codDocente) REFERENCES Usuario(codUsuario),
  FOREIGN KEY (codGrado) REFERENCES Grado(codGrado)
);

CREATE TABLE Administrador(
  codAdministrador CHAR(9) PRIMARY KEY NOT NULL,
  codRol CHAR(1) NOT NULL,
  FOREIGN KEY (codAdministrador) REFERENCES Usuario(codUsuario),
  FOREIGN KEY (codRol) REFERENCES RolAdministrador(codRol)
);

CREATE TABLE Pago(
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

CREATE TABLE Mensaje(
  codMensaje CHAR(5) PRIMARY KEY NOT NULL,
  fechaMensaje DATE NOT NULL,
  codEstudiante CHAR(9) NOT NULL,
  codTipoMensaje CHAR(1) NOT NULL,
  codEstadoMensaje CHAR(1) NOT NULL,
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codTipoMensaje) REFERENCES TipoMensaje(codTipoMensaje),
  FOREIGN KEY (codEstadoMensaje) REFERENCES EstadoMensaje(codEstadoMensaje)
);

CREATE TABLE Ciclo(
  codCiclo CHAR(4) PRIMARY KEY NOT NULL,
  fechaInicioCiclo DATE NOT NULL,
  fechaFinCiclo DATE NOT NULL,
  codModalidadCiclo CHAR(1) NOT NULL,
  FOREIGN KEY (codModalidadCiclo) REFERENCES ModalidadCiclo(codModalidadCiclo)
);

CREATE TABLE AdministradorMensaje(
  codAdministrador CHAR(9) NOT NULL,
  codMensaje CHAR(5) NOT NULL,
  fechaAtencion DATE NOT NULL,
  PRIMARY KEY (codAdministrador, codMensaje),
  FOREIGN KEY (codAdministrador) REFERENCES Administrador(codAdministrador),
  FOREIGN KEY (codMensaje) REFERENCES Mensaje(codMensaje)
);

CREATE TABLE ProcesoMatricula(
  codProceso CHAR(4) PRIMARY KEY NOT NULL,
  fechaProceso DATE NOT NULL,
  horaInicioProceso NUMERIC(4) NOT NULL,
  horaFinProceso NUMERIC(4) NOT NULL,
  tipoProceso CHAR(1) NOT NULL,
  codCiclo CHAR(4) NOT NULL,
  FOREIGN KEY (tipoProceso) REFERENCES CondicionMatricula(codCondicionMatric),
  FOREIGN KEY (codCiclo) REFERENCES Ciclo(codCiclo)
);

CREATE TABLE Curso(
  codCurso CHAR(5) PRIMARY KEY NOT NULL,
  nombreCurso VARCHAR(50) NOT NULL,
  pesoCreditos INT NOT NULL,
  codCursoPrereq CHAR(5),
  codTipoCurso CHAR(1) NOT NULL,
  FOREIGN KEY (codCursoPrereq) REFERENCES Curso(codCurso),
  FOREIGN KEY (codTipoCurso) REFERENCES TipoCurso(codTipoCurso)
);

CREATE TABLE Seccion(
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

CREATE TABLE HistorialMatricula(
  codEstudiante CHAR(9) NOT NULL,
  codCurso CHAR(5) NOT NULL,
  numeroVeces NUMERIC(1) NOT NULL,
  codEstadoCurso CHAR(1) NOT NULL,
  PRIMARY KEY (codEstudiante, codCurso),
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codCurso) REFERENCES Curso(codCurso),
  FOREIGN KEY (codEstadoCurso) REFERENCES EstadoCurso(codEstadoCurso)
);

CREATE TABLE Matricula(
  codEstudiante CHAR(9) NOT NULL,
  codCurso CHAR(5) NOT NULL,
  codSeccion CHAR(1) NOT NULL,
  codTipoSeccion CHAR(1) NOT NULL,
  PRIMARY KEY (codEstudiante, codCurso, codSeccion),
  FOREIGN KEY (codEstudiante) REFERENCES Estudiante(codEstudiante),
  FOREIGN KEY (codCurso, codSeccion, codTipoSeccion) REFERENCES Seccion(codCurso, codSeccion, codTipoSeccion)
);

INSERT INTO Usuario VALUES ('20212122G', 'qetuoe13579', 'Josue', 'Juarez', 'Sihuay', 'Reymundo', TO_DATE('2002-05-26', 'YYYY-MM-DD'), 'josue.juarez.s@uni.pe', 957175390);
INSERT INTO Usuario VALUES ('20062072M', 'asdjkl123', 'Pedro', 'Linares', 'Reynoso', 'Alberto', TO_DATE('2001-03-24', 'YYYY-MM-DD'), 'pedro.linares.r@uni.pe', 994578721);
INSERT INTO Usuario VALUES ('20018441C', 'cvbjhg841', 'Jorge', 'Llanos', 'Panduro', 'Daniel', TO_DATE('1960-05-13', 'YYYY-MM-DD'), 'jdllanosp@uni.edu.pe', 967264124);

INSERT INTO CondicionMatricula VALUES ('1', 'Promocion');
INSERT INTO CondicionMatricula VALUES ('2', 'Regular');
INSERT INTO CondicionMatricula VALUES ('3', 'En riesgo');
INSERT INTO CondicionMatricula VALUES ('4', 'Reintegrado');
INSERT INTO CondicionMatricula VALUES ('5', 'Rezagado');

INSERT INTO Grado VALUES ('1', 'Bachillerato');
INSERT INTO Grado VALUES ('2', 'Licenciatura');
INSERT INTO Grado VALUES ('3', 'Maestr a');
INSERT INTO Grado VALUES ('4', 'Especialidad');
INSERT INTO Grado VALUES ('5', 'Doctorado');

INSERT INTO RolAdministrador VALUES ('1', 'Comision de Matricula');
INSERT INTO RolAdministrador VALUES ('2', 'TEFIIS');
INSERT INTO RolAdministrador VALUES ('3', 'Director de Escuela');
INSERT INTO RolAdministrador VALUES ('4', 'Oficina de Estad stica');

INSERT INTO EstadoPago VALUES ('1', 'Pago realizado');
INSERT INTO EstadoPago VALUES ('2', 'Pago pendiente');
INSERT INTO EstadoPago VALUES ('3', 'Pago en proceso');
INSERT INTO EstadoPago VALUES ('4', 'Pago rechazado');

INSERT INTO TipoCurso VALUES ('A', 'Curso electivo');
INSERT INTO TipoCurso VALUES ('B', 'Curso de carrera');
INSERT INTO TipoCurso VALUES ('C', 'Curso general');

INSERT INTO TipoSeccion VALUES ('T', 'Teor a');
INSERT INTO TipoSeccion VALUES ('P', 'Pr ctica');
INSERT INTO TipoSeccion VALUES ('L', 'Laboratorio');

INSERT INTO Dia VALUES ('L', 'Lunes');
INSERT INTO Dia VALUES ('M', 'Martes'); 
INSERT INTO Dia VALUES ('X', 'Miercoles');
INSERT INTO Dia VALUES ('J', 'Jueves');
INSERT INTO Dia VALUES ('V', 'Viernes');
INSERT INTO Dia VALUES ('S', 'Sabado');

INSERT INTO TipoMensaje VALUES ('A', 'Problema con la carga horaria y de programaci n de horarios');
INSERT INTO TipoMensaje VALUES ('B', 'Problema por el n mero de vacantes disponibles');
INSERT INTO TipoMensaje VALUES ('C', 'Problema con la matr cula de un curso');
INSERT INTO TipoMensaje VALUES ('D', 'Problemas t cnicos y de la plataforma para la matr cula');
INSERT INTO TipoMensaje VALUES ('E', 'Problemas con la ficha de matr cula (Cruces)');

INSERT INTO EstadoMensaje VALUES ('S', 'Sin atender');
INSERT INTO EstadoMensaje VALUES ('P', 'En proceso de soluci n');
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
INSERT INTO EstadoCurso VALUES ('B', 'Curso Regular Desaprobado');
INSERT INTO EstadoCurso VALUES ('C', 'Curso Electivo');
INSERT INTO EstadoCurso VALUES ('D', 'Curso Electivo Desaprobado');

INSERT INTO Estudiante VALUES ('20212122G', 'I2', 4, 43, '1', 14.57 , '0', '2', 'T0003');

INSERT INTO Docente VALUES ('20018441C', 12, '4');

INSERT INTO Administrador VALUES ('20062072M', '2');

INSERT INTO Pago VALUES ('46552296', '20212122G', 'Scotiabank', TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2023-01-26', 'YYYY-MM-DD'), TO_DATE('2023-02-14', 'YYYY-MM-DD'), '1');

INSERT INTO Mensaje VALUES ('M0001', TO_DATE('2023-03-22', 'YYYY-MM-DD'), '20212122G', 'B', 'P');

INSERT INTO Ciclo VALUES ('23-1', TO_DATE('2023-04-02', 'YYYY-MM-DD'), TO_DATE('2023-07-27', 'YYYY-MM-DD'), 'P');

INSERT INTO AdministradorMensaje VALUES ('20062072M', 'M0001', TO_DATE('2023-03-22', 'YYYY-MM-DD'));

INSERT INTO ProcesoMatricula VALUES ('P001', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1015, 1120, '2', '23-1');

INSERT INTO Curso VALUES ('BIC01', 'INTRODUCCION A LA COMPUTACION', 2, NULL, 'B');
INSERT INTO Curso VALUES ('SI205', 'ALGORITMIA Y ESTRUCTURA DE DATOS', 3, 'BIC01', 'B');

INSERT INTO Seccion VALUES ('V', 'BIC01', 'L', 0800, 1000, 20, 18, 'S4234', 'M', '20018441C', '23-1');

INSERT INTO HistorialMatricula VALUES ('20212122G', 'BIC01', 1, 'A');

INSERT INTO Matricula VALUES ('20212122G', 'BIC01', 'V', 'L');

QUERYS:
-- Query #1
SELECT codUsuario, contrasena,primerNombre from Usuario 
WHERE codUsuario = '20212122G' AND contrasena = 'qetuoe13579';

-- Query #2
UPDATE usuario set contrasena = 'cambiouwu'
where codUsuario = '20212122G' 
and correoUsuario = 'josue.juarez.s@uni.pe'
and fechaNacimiento = '2002-05-26';

-- Query #3
SELECT codTurno, numeroTurno, fechaTurno, horaInicioTurno, horaFinTurno, tipoTurno from Turno;

-- Query #4
SELECT C.codCurso, C.nombreCurso, C.pesoCreditos, HM.numeroVeces, C.codTipoCurso, 
C.codCursoPrereq, E.numeroCreditos
FROM Curso C, HistorialMatricula HM, Estudiante E
WHERE C.codCurso = HM.codCurso 
AND HM.codEstudiante = E.codEstudiante
AND E.codEstudiante = '20212122G';


SELECT  C.nombreCurso,S.codSeccion, U.apellidoPaterno, U.apellidoMaterno, 
U.primerNombre, S.codTipoSeccion, DI.nombreDia,  S.horaInicioSeccion, S.horaFinSeccion, S.codAula
FROM Seccion S, Docente D, Dia DI, Estudiante E, Matricula M, Usuario U, Curso C
WHERE DI.codDia = S.codDia
AND S.codDocente = D.codDocente 
AND D.codDocente = U.codUsuario
AND S.codSeccion = M.codSeccion
AND S.codCurso = C.codCurso
AND M.codEstudiante = E.codEstudiante
AND C.codCurso = 'BIC01'
AND E.codEstudiante = '20212122G';

-- Query #5
	-- Falta agregar C.imagenSilabo
SELECT C.codCurso, C.nombreCurso, C.pesoCreditos, S.numVacantes
FROM Curso C
INNER JOIN Seccion S
ON S.codCurso = C.codCurso;

	-- Se visualiza todos los cursos en el buscador
SELECT nombreCurso, codCurso FROM Curso;

	-- Filtro de búsqueda en el buscador: El codCurso y nombreCurso es seleccionado por el usuario
SELECT  C.codcurso,S.codSeccion, U.apellidoPaterno, U.apellidoMaterno, 
U.primerNombre, S.codTipoSeccion, DI.nombreDia,  S.horaInicioSeccion, S.horaFinSeccion, S.codAula
FROM Seccion S, Docente D, Dia DI, Usuario U, Curso C
WHERE S.codDocente = D.codDocente 
AND S.codCurso = C.codCurso
AND D.codDocente = U.codUsuario
AND DI.codDia = S.codDia
AND (C.codCurso = 'BIC01'  OR C.nombreCurso = 'INTRODUCCION A LA COMPUTACION');

-- Query #6
UPDATE seccion set numVacantes = 21 
where codCurso = 'BIC01' 
AND codSeccion = 'V';
	
	-- Parte visual, captar el codCurso y mostrar sus secciones respectivas
SELECT S.codSeccion, C.codCurso, C.nombreCurso, S.numVacantesOcupadas, S.numVacantes
FROM Seccion S, Curso C, Estudiante E, HistorialMatricula HM
WHERE S.codCurso = C.codCurso
AND HM.codCurso = C.codCurso
AND HM.codEstudiante = E.codEstudiante
AND E.codestudiante = '20212122G';

-- Query #7
	-- Al seleccionar el boton +
UPDATE seccion set numVacantesOcupadas = numVacantesOcupadas +1 
WHERE codCurso = 'BIC01' 
AND codSeccion = 'V';

SELECT  T.numeroTurno, T.horaInicioTurno, T.horaFinTurno
FROM Estudiante E
INNER JOIN Turno T
ON E.codTurno = T.codTurno where codEstudiante = '20212122G';

SELECT C.codCurso, C.nombreCurso, C.pesoCreditos, HM.numeroVeces, C.codTipoCurso
FROM Seccion S, Curso C, HistorialMatricula HM, Estudiante E
WHERE S.codCurso = C.codCurso
AND HM.codCurso = C.codCurso
AND HM.codEstudiante = E.codEstudiante
AND E.codEstudiante = '20212122G';

	-- Se mostrarán los créditos permitidos en el tercer cuadradito
SELECT numeroCreditos FROM Estudiante 
WHERE codEstudiante = '20212122G';

	-- Al presionar el botón +, se tiene que guardar la información del curso y sección

-- Query #8
SELECT M.codCurso, C.nombreCurso, M.codSeccion, M.codTipoSeccion, U.apellidoPaterno, 
U.apellidoMaterno, U.primerNombre, DI.nombreDia, S.horaInicioSeccion, S.horaFinSeccion, S.codAula
FROM Curso C, Seccion S, Docente D, Estudiante E, Matricula M, Dia DI, Usuario U
WHERE C.codCurso = S.codCurso
AND S.codDocente = D.codDocente
AND D.codDocente = U.codUsuario
AND S.codDia = DI.codDia
AND S.codSeccion=M.codSeccion
AND M.codEstudiante = E.codEstudiante
AND E.codEstudiante = '20212122G'; 

-- Query #9
	-- Se debe filtrar el código del login para mostrar ello
SELECT U.primerNombre, U.apellidoPaterno
FROM Administrador A
INNER JOIN Usuario U
ON A.codAdministrador = U.codUsuario;

SELECT U.apellidoPaterno, U.apellidoMaterno, U.primerNombre, 
M.codTipoMensaje, M.fechaMensaje, M.codEstadoMensaje
FROM Mensaje M, Estudiante E, Usuario U
WHERE M.codEstudiante = E.codEstudiante
AND E.codEstudiante = U.codUsuario;

-- Query #10
	-- Parte superior izquierdo
SELECT U.primerNombre, U.apellidoPaterno
FROM Administrador A
INNER JOIN Usuario U
ON A.codAdministrador = U.codUsuario;

SELECT U.APELLIDOPATERNO,U.APELLIDOMATERNO ,U.PRIMERNOMBRE , M.CODTIPOMENSAJE ,M.FECHAMENSAJE ,
AM.FechaAtencion ,U1.APELLIDOPATERNO ,U1.APELLIDOMATERNO ,U1.PRIMERNOMBRE 
FROM Usuario U, Estudiante E, Administrador A, Mensaje M, AdministradorMensaje AM, Usuario U1
WHERE E.codEstudiante = U.codUsuario
AND M.codEstudiante = E.codEstudiante
AND AM.codMensaje = M.codMensaje
AND AM.codAdministrador = A.codAdministrador
AND A.codAdministrador = U1.codUsuario;



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

SELECT numeroTurno, fechaTurno, horaInicioTurno, horaFinTurno FROM Turno;

SELECT codCurso||codSeccion||codTipoSeccion
FROM Seccion;

CREATE TABLE Turno2(
    cod_turno CHAR(5) PRIMARY KEY NOT NULL,
    numero_turno NUMERIC(2) NOT NULL,
    fecha_turno DATE NOT NULL,
    hora_inicio_turno NUMERIC(4) NOT NULL,
    hora_fin_turno NUMERIC(4) NOT NULL,
    tipo_turno CHAR(1) NOT NULL
);

INSERT INTO Turno2 VALUES ('T0000', '0', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 0800, 0900, '1');
INSERT INTO Turno2 VALUES ('T000R', '0', TO_DATE('2023-03-21', 'YYYY-MM-DD'), 0800, 0900, '3');
INSERT INTO Turno2 VALUES ('T0001', '1', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 0800, 0900, '2');
INSERT INTO Turno2 VALUES ('T0002', '2', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 0930, 1030, '2');
INSERT INTO Turno2 VALUES ('T0003', '3', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1000, 1100, '2');
INSERT INTO Turno2 VALUES ('T0004', '4', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1130, 1230, '2');
INSERT INTO Turno2 VALUES ('T0005', '5', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1200, 1300, '2');
INSERT INTO Turno2 VALUES ('T0006', '6', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1330, 1430, '2');
INSERT INTO Turno2 VALUES ('T0007', '7', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1400, 1500, '2');
INSERT INTO Turno2 VALUES ('T0008', '8', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1530, 1630, '2');
INSERT INTO Turno2 VALUES ('T0009', '9', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1600, 1700, '2');
INSERT INTO Turno2 VALUES ('T0010', '10', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1730, 1830, '2');
INSERT INTO Turno2 VALUES ('T0011', '11', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1800, 1900, '2');
INSERT INTO Turno2 VALUES ('T0012', '12', TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1930, 2030, '2');
INSERT INTO Turno2 VALUES ('T0013', '13', TO_DATE('2023-03-23', 'YYYY-MM-DD'), 1400, 1500, '5');

select * from Turno2;