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



