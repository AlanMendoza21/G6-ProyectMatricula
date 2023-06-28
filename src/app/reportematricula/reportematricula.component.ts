import { Component, OnInit } from '@angular/core';
import {ApiService} from "../../ApiService";
import {ActivatedRoute} from "@angular/router";
import {Matricula, ReporteMatricula, Seccion} from "../../interfaces";

@Component({
  selector: 'app-reportematricula',
  templateUrl: './reportematricula.component.html',
  styleUrls: ['./reportematricula.component.scss']
})
export class ReportematriculaComponent implements OnInit {
  codUsuario: string="";
  secciones:ReporteMatricula[]=[];
  constructor(private api:ApiService, private activatedRoute: ActivatedRoute) {
    this.codUsuario = String(this.activatedRoute.snapshot.paramMap.get('codUsuario'));
    //console.log(this.codUsuario)


    this.api.reporteMatricula(this.codUsuario).subscribe(data=>{
      this.secciones=data.listarep;
    })
  }

  ngOnInit(): void {
    //console.log(this.secciones)
  }

}
