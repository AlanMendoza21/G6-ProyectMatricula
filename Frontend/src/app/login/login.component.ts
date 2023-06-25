import { Component, OnInit } from '@angular/core';
import {ApiService} from "../../ApiService";
import {Usuario} from "../../interfaces";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  codigo:string="";
  contrasena:string="";

  usuarios: Usuario[]=[];
  //indice:number=0;
  mensaje: string="";

  constructor(private api:ApiService) { }

  ngOnInit(): void {
    this.valida()
  }
//usuario nombre, contraseña codigo

 valida():boolean{
    this.api.obtenerUsuarios().subscribe(data=>{this.usuarios= data.usuarios,
      console.log(this.usuarios)})
    let validado = false;
    let indice1= 0;
    while(this.usuarios[indice1]!= null){
      //console.log(this.usuarios[this.indice])
      if(this.usuarios[indice1].codUsuario==this.codigo &&
        this.usuarios[indice1].contrasena==this.contrasena) {
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
    this.valida()
    if(this.valida()==true){
      this.mensaje = "Usuario validado";
    }
    else if(this.valida()==false){
      this.mensaje = "Error, vuelva a intentar";}
    console.log("Mensaje: ")
    console.log(this.mensaje)
  }
}
