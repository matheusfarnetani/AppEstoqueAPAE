import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './pages/login/login.component';
import { RecsenhaComponent } from './pages/recsenha/recsenha.component';
import { RedsenhaComponent } from './pages/redsenha/redsenha.component';
import { HomeComponent } from './pages/home/home.component';
import { AdminComponent } from './pages/admin/admin.component';
import { EstoqueComponent } from './pages/estoque/estoque.component';
import { DoacaoComponent } from './pages/doacao/doacao.component';
import { AdminuserComponent } from './pages/adminuser/adminuser.component';

const routes: Routes = [

  {path:'', component: LoginComponent},
  {path:'redsenha', component: RedsenhaComponent},
  {path:'recsenha', component: RecsenhaComponent},
  {path:'home', component: HomeComponent},
  {path:'admin', component: AdminComponent},
  {path:'adminuser', component: AdminuserComponent},
  {path:'estoque', component: EstoqueComponent},
  {path:'doacao', component: DoacaoComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
