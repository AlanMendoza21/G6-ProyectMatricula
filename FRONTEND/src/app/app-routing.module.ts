import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from "./login/login.component";
import {MatriculaComponent} from "./matricula/matricula.component";
import {SeccionComponent} from "./seccion/seccion.component";
import {InicioComponent} from "./inicio/inicio.component";

const routes: Routes = [
  {path:"login", component: LoginComponent},
  {path:"matricula/:codUsuario", component: MatriculaComponent},
  {path:"seccion/:codUsuario/:codCurso", component: SeccionComponent},
  {path:"inicio/:codUsuario",component:InicioComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
