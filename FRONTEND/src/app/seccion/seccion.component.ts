import { Component, OnInit } from '@angular/core';
import {ApiService} from "../../ApiService";
import {ActivatedRoute} from "@angular/router";
import {Matricula, Seccion} from "../../interfaces";

@Component({
  selector: 'app-seccion',
  templateUrl: './seccion.component.html',
  styleUrls: ['./seccion.component.scss']
})
export class SeccionComponent implements OnInit {
  codCurso: string="";
  codUsuario: string="";
  secciones:Seccion[]=[];
  constructor(private api:ApiService, private activatedRoute: ActivatedRoute) {
    this.codUsuario = String(this.activatedRoute.snapshot.paramMap.get('codUsuario'));
    //console.log(this.codUsuario)

    this.codCurso = String(this.activatedRoute.snapshot.paramMap.get('codCurso'));
    //console.log(this.codCurso)

    this.api.obtenerSecciones(this.codCurso).subscribe(data=>{
      this.secciones=data.secciones;
    })
  }

  ngOnInit(): void {
    //console.log(this.secciones)
  }

  registrar(data1:string, data2:string, data3:string, data4:string){
    const matricula={
      codEstudiante: data1,
      codCurso: data3,
      codSeccion: data2,
      codTipoSeccion: data4
    }
    this.api.registrarMatricula(matricula).subscribe(data=>{console.log(matricula)});
  }
}
