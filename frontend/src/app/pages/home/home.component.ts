import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export  class  HomeComponent  implements OnInit {

  isModalOpen = false;
  name: string = "";

  ngOnInit() {
    this.name = localStorage.getItem('userName') ?? 'erro'
  } 

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

}
