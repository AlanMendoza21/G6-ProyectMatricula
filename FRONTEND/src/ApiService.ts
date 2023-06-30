import {Injectable} from "@angular/core";
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {catchError, Observable, retry, throwError} from "rxjs";
import {
  Matricula,
  RespuestaCursoDisponibleEstudiante, RespuestaReporteMatricula,
  RespuestaSeccion,
  RespuestaUsuario,
  Turno,
  Turnos,
  Usuario
} from "./interfaces";

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json;charset=utf-8'
    })
  };
  errorHandl(error:any) {
    let errorMessage = '';
    if (error.error instanceof ErrorEvent) {
      errorMessage = error.error.message;
    } else {
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }
    console.log(errorMessage);
    return throwError(errorMessage);
  }

  constructor(private http: HttpClient) { }

  obtenerUsuario(data:Usuario): Observable<Usuario> {
    return this.http.post<Usuario>('http://localhost:8080/obtenerUsuario', data,
      this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl)); }
  obtenerUsuarios(): Observable<RespuestaUsuario> {
    return this.http.post<RespuestaUsuario>('http://localhost:8080/obtenerUsuarios', null,
      this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl));  }
  obtenerTurnos(): Observable<Turnos> {
    return this.http.post<Turnos>("http://localhost:8080/obtenerTurnos", null, this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl));  }
                          //codUsuario
  obtenerCursosDisponible(data: string): Observable<RespuestaCursoDisponibleEstudiante> {
    return this.http.post<RespuestaCursoDisponibleEstudiante>('http://localhost:8080/obtenerCursosDisponible', data,
      this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl));
  }
                //codCurso
  obtenerSecciones(data:string): Observable<RespuestaSeccion> {
    return this.http.post<RespuestaSeccion>('http://localhost:8080/obtenerSecciones', data,
      this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl));
  }
                      //codUsuario
  obtenerTurnoEstudiante(data:string): Observable<Turno> {
    return this.http.post<Turno>('http://localhost:8080/obtenerTurnoEstudiante', data,
      this.httpOptions)
      .pipe(retry(1),
        catchError(this.errorHandl));
  }

  registrarMatricula(data:Matricula): Observable<Matricula> {
    return this.http.post<Matricula>('http://localhost:8080/registrarMatricula', data,
      this.httpOptions)
      .pipe(retry(1), catchError(this.errorHandl));
  }

  actualizarMatricula(data:Matricula): Observable<Matricula> {
    return this.http.post<Matricula>('http://localhost:8080/actualizarMatricula', data,
      this.httpOptions)
      .pipe(retry(1),catchError(this.errorHandl));
  }

  reporteMatricula(data:string): Observable<RespuestaReporteMatricula> {
    return this.http.post<RespuestaReporteMatricula>('http://localhost:8080/obtenerReporteMatricula', data,
      this.httpOptions)
      .pipe(
        retry(1),
        catchError(this.errorHandl)
      );
  }

}
