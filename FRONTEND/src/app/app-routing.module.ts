import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from "./login/login.component";
import {MatriculaComponent} from "./matricula/matricula.component";
import {SeccionComponent} from "./seccion/seccion.component";

const routes: Routes = [
  {path:"login", component: LoginComponent},
  {path:"matricula/:codUsuario", component: MatriculaComponent},
  {path:"seccion/:codCurso", component: SeccionComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
