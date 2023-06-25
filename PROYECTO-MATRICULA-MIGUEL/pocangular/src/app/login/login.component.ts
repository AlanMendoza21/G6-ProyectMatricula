import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  codUsuario: string="";
  contrasena: string=""

  constructor() {
  }

  ngOnInit():void{
  }

  login(): void {
    console.log("Codigo usuario: "+this.codUsuario);
    console.log("Contrasena: " + this.contrasena)
  }
}
