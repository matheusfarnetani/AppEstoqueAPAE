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
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AdminuserComponent } from './pages/adminuser/adminuser.component';
import { HttpClientModule } from '@angular/common/http'; // Adicionado para HttpClient
import { FilterPipeModule } from 'ngx-filter-pipe';


import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { CorsInterceptor } from '../cors.interceptor';
import { ItemCardComponent } from './item-card/item-card.component';

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
    AdminuserComponent,
    ItemCardComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule, 
    CommonModule, 
    FormsModule, 
    ReactiveFormsModule,
    FilterPipeModule
  ],
  providers: [{ provide: HTTP_INTERCEPTORS, useClass: CorsInterceptor, multi: true },],
  bootstrap: [AppComponent]
})

export class AppModule { }
