import { Component, OnInit } from '@angular/core';
import {ApiService} from "../../ApiService";
import {Usuario} from "../../interfaces";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  codUsuario:string="";
  contrasena:string="";

  usuarios: Usuario[]=[];
  //indice:number=0;
  mensaje: string="";

  constructor(private api:ApiService) { }

  ngOnInit(): void {
    this.validar()
  }
//usuario nombre, contraseña codigo

  validar():boolean{
    this.api.obtenerUsuarios().subscribe(data=>{this.usuarios= data.usuarios,
      console.log(this.usuarios)})
    let validado = false;
    let indice1= 0;
    while(this.usuarios[indice1]!= null){
      //console.log(this.usuarios[this.indice])
      if(this.usuarios[indice1].codUsuario==this.codUsuario &&
        this.usuarios[indice1].contrasena==this.contrasena) {
        //console.log(this.usuarios[this.indice].cod_cliente)
        //console.log(this.usuarios[this.indice].nombres)
        //this.codigo=this.usuarios[indice1].codUsuario;
        validado=true;
        break;
      }
      else{indice1++;}
    }
    console.log(indice1)
    console.log(validado)
    console.log(this.codUsuario)
    return validado;
  }
  mostrarMensaje() {
    this.validar()
    if(this.validar()){
      this.mensaje = "Usuario validado";
      console.log(this.mensaje)
    }
    else if(this.validar()==false){
      this.mensaje = "Error, vuelva a intentar";}
    console.log("Mensaje: ")
    console.log(this.mensaje)
  }
}
