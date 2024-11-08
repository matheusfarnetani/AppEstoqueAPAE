import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './pages/login/login.component';
import { RecsenhaComponent } from './pages/recsenha/recsenha.component';
import { RedsenhaComponent } from './pages/redsenha/redsenha.component';
import { HomeComponent } from './pages/home/home.component';
import { AdminComponent } from './pages/admin/admin.component';
import { EstoqueComponent } from './pages/estoque/estoque.component';
import { DoacaoComponent } from './pages/doacao/doacao.component';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AdminuserComponent } from './pages/adminuser/adminuser.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RecsenhaComponent,
    RedsenhaComponent,
    HomeComponent,
    AdminComponent,
    EstoqueComponent,
    DoacaoComponent,
    AdminuserComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
