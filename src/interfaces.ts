export interface Usuario{
  codUsuario: string;
  contrasena:string ;
  primerNombre:string;
  segundoNombre:string;
  apellidoPaterno:string;
  apellidoMaterno:string;
  fechaNacimiento:string;
  correoUsuario:string;
  telefonoUsuario:string;
}

export interface RespuestaUsuario{
  usuarios: Usuario[];
}

export interface CursoDisponibleEstudiante {
  codCurso: string;
  nombreCurso: string;
  pesoCreditos: number;
  numeroVeces: number;
  codTipoCurso: string;
  numeroCreditos: number; //Créditos del alumno
}

export interface RespuestaCursoDisponibleEstudiante {
  curso_disponibles: CursoDisponibleEstudiante[];
}

export interface Seccion {
  codCurso: string;
  nombreCurso: string;
  codSeccion: string;
  codTipoSeccion: string;
  apellidoPaterno: string;
  apellidoMaterno: string;
  primerNombre: string;
  nombreDia: string;
  horaInicioSeccion: number;
  horaFinSeccion: number;
  numVacantesOcupadas: number;
  numVacantes: number;
}

export interface  RespuestaSeccion {
  secciones: Seccion[];
}

export interface Turno {
  codTurno: string;
  numeroTurno: number;
  fechaTurno: string;
  horaInicioTurno: number;
  horaFinTurno: number;
  tipoTurno: string;
}
export interface Turnos{
  turnos: Turno[]
}
export interface Estudiante{
  codEstudiante: string;
  especialidad: string;
  cicloRelativo : number;
  numeroCreditos: number;
  matriculaHabilitada: string;
  promedioPonderado : number;
  matriculaHecha: string;
  codCondicionMatric: string;
  codTurno: string;
}

export interface Matricula {
  codEstudiante: string;
  codCurso: string;
  codSeccion: string;
  codTipoSeccion: string;
}
export interface ReporteMatricula {
   codCurso: string;
   nombreCurso: string;
   codSeccion: string;
   descripcionTipoSeccion: string;
   apellidoPaterno: string;
   apellidoMaterno: string;
   primerNombre: string;
   nombreDia: string;
   horaInicioSeccion: number;
   horaFinSeccion: number;
   codAula: string;
}
export interface ListRep{
  listarep: ReporteMatricula[];
}



