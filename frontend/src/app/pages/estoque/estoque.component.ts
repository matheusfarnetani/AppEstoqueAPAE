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
  
  isAddItemModalOpen = false;
  isRemoveItemModalOpen = false;

  abrirAddItemModal() {
    this.isAddItemModalOpen = true;
  }

  fecharAddItemModal() {
    this.isAddItemModalOpen = false;
  }

  abrirRemoveItemModal() {
    this.isRemoveItemModalOpen = true;
  }

  fecharRemoveItemModal() {
    this.isRemoveItemModalOpen = false;
  }
}
