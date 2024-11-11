import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

@Component({
  selector: 'app-estoque',
  templateUrl: './estoque.component.html',
  styleUrl: './estoque.component.css'
})
export class EstoqueComponent {
  isModalOpen = false;
  isAddItemModalOpen = false;
  isRemoveItemModalOpen = false;
  isConfirmAddModal = false;
  isConfirmRemoveModal = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false; 
  }

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

  confirmarAddItem(){
    this.isConfirmAddModal = true;
  
  setTimeout(() => {
    this.isConfirmAddModal = false;
  },2000)
 }

  confirmarRemoveItem(){
    this.isConfirmRemoveModal = true;
  
  setTimeout(() => {
    this.isConfirmRemoveModal = false;
  },2000)
 }

 filtroSelecionado: string = ''; 

  selecionarFiltro(filtro: string): void {
    this.filtroSelecionado = filtro;
  }
}
