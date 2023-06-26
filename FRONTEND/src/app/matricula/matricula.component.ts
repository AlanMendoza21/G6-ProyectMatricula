import { Component, OnInit } from '@angular/core';
import {ActivePerfRecorder} from "@angular/compiler-cli/src/ngtsc/perf";
import {ActivatedRoute} from "@angular/router";
import {ApiService} from "../../ApiService";
import {CursoDisponibleEstudiante, Turno} from "../../interfaces";

@Component({
  selector: 'app-matricula',
  templateUrl: './matricula.component.html',
  styleUrls: ['./matricula.component.scss']
})
export class MatriculaComponent implements OnInit {
  codUsuario: string='';
  lista: CursoDisponibleEstudiante[]=[];
  numeroTurno: number=-1;
  horaInicioTurno: number=-1;
  horaFinTurno: number=-1;
  fechaTurno: string="";

  constructor(private api:ApiService, private activatedRoute: ActivatedRoute) {

    this.codUsuario = String(this.activatedRoute.snapshot.paramMap.get('codUsuario'));
    console.log(this.codUsuario)

    this.api.obtenerTurnoEstudiante(this.codUsuario).subscribe(data=>{
      this.numeroTurno = data.numeroTurno; this.horaInicioTurno=data.horaInicioTurno;
      this.horaFinTurno=data.horaFinTurno; this.fechaTurno=data.fechaTurno;
      console.log(this.numeroTurno)
    })

    this.api.obtenerCursosDisponible(this.codUsuario).subscribe(data=>{
      this.lista = data.curso_disponibles; console.log(this.lista)
      console.log(this.lista)
    })
  }

  ngOnInit(): void {

  }
}
