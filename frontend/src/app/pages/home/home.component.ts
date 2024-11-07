import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {

   isModalOpen = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

}
