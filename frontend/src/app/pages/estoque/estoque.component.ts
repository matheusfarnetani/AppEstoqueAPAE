import { Component } from '@angular/core';

@Component({
  selector: 'app-estoque',
  templateUrl: './estoque.component.html',
  styleUrl: './estoque.component.css'
})
export class EstoqueComponent {
  isModalOpen = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }
}
