import { Component, OnInit } from '@angular/core';
import {ApiService} from "../../ApiService";
import {ActivatedRoute} from "@angular/router";

@Component({
  selector: 'app-seccion',
  templateUrl: './seccion.component.html',
  styleUrls: ['./seccion.component.scss']
})
export class SeccionComponent implements OnInit {
  codCurso: string="";

  constructor(private api:ApiService, private activatedRoute: ActivatedRoute) {
    this.codCurso = String(this.activatedRoute.snapshot.paramMap.get('codCurso'));
    console.log(this.codCurso)

  }

  ngOnInit(): void {
  }

}
