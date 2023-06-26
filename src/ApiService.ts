import {Injectable} from "@angular/core";
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {catchError, Observable, retry, throwError} from "rxjs";
import {RespuestaUsuario, Turno, Turnos, Usuario} from "./interfaces";

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
      .pipe(
        retry(1),
        catchError(this.errorHandl)
      );
  }
  obtenerUsuarios(): Observable<RespuestaUsuario> {
    return this.http.post<RespuestaUsuario>('http://localhost:8080/obtenerUsuarios', null,
      this.httpOptions)
      .pipe(
        retry(1),
        catchError(this.errorHandl)
      );
  }
  obtenerTurnos(): Observable<Turnos> {
    return this.http.post<Turnos>("http://localhost:8080/obtenerTurnos", null, this.httpOptions)
        .pipe(
            retry(1),
            catchError(this.errorHandl)
        );
  }
  obtenerTurnosEstudiante(codigo: string): Observable<Turno> {
    return this.http.post<Turno>("http://localhost:8080/obtenerTurnoEstudiante", null, this.httpOptions)
        .pipe(
            retry(1),
            catchError(this.errorHandl)
        );
  }

}
