import { Component, OnInit } from '@angular/core';
import {Turno, Turnos} from "../../interfaces";
import {ApiService} from "../../ApiService";

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.scss']
})
export class InicioComponent implements OnInit {
  lista:Turno[]= [];
  CodTurno: string="";
  mensaje: string="";
  codUsuario: string="";
  constructor(private api:ApiService) { }

  ngOnInit(): void {
    // @ts-ignore
    this.api.obtenerTurnos().subscribe(data=> {
      this.lista=data.turnos;});
  }


  obtenerHoraActual(): string {
    const now = new Date();
    const hours = ('0' + now.getHours()).slice(-2);
    const minutes = ('0' + now.getMinutes()).slice(-2);
    return hours + minutes;
  }
  convertirHoraEntero(): number {
    const horaActualString = this.obtenerHoraActual();
    const horaActualEntero = parseInt(horaActualString, 10);
    return horaActualEntero;
  }

  obtenerTurno():boolean{
    this.api.obtenerTurnosEstudiante('20212122G').subscribe(data=>{this.CodTurno=data.codTurno,
        console.log(this.CodTurno)})
    let validado = false;
    let indice1= 0;
    const horaActual = this.convertirHoraEntero();
    while(this.lista[indice1]!= null){
      //console.log(this.usuarios[this.indice])

      if(this.lista[indice1].codTurno==this.CodTurno
          && this.lista[indice1].horaInicioTurno< 1030
          && this.lista[indice1].horaFinTurno>1030) {
        //console.log(this.usuarios[this.indice].cod_cliente)
        //console.log(this.usuarios[this.indice].nombres)
        validado=true;
        break;
      }
      else{indice1++;}
    }
    console.log(indice1)
    console.log(validado)
    return validado;
  }
  mostrarMensaje() {
    this.obtenerTurno()
    if(this.obtenerTurno()==true){
      this.mensaje= "Horario correcto";
    }
    else if(this.obtenerTurno()==false){
      this.mensaje = "No es su hora de matricula";}
    console.log(this.mensaje)
  }


}
