import { Component } from '@angular/core';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css'
})
export class AdminComponent {

  isModalOpen = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

}
