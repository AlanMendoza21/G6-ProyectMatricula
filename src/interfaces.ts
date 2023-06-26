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

export interface Turno{
  codTurno: string;
  numeroTurno: number;
  fechaTurno: string;
  horaInicioTurno: number;
  horaFinTurno: number;
  tipoTurno : string;
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



