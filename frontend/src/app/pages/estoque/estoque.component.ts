import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

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


  formulario = new FormGroup({
    idcons: new FormControl ('', [Validators.required]),
    quant: new FormControl ('', [Validators.required]),
    unidade: new FormControl ('', [Validators.required]),
    iddoacao: new FormControl ('', [Validators.required]),
    dataentrada: new FormControl ('', [Validators.required]),
    dataval: new FormControl ('', [Validators.required]),
    datasaida: new FormControl ('', [Validators.required,]),
    obs: new FormControl ('', [Validators.required]),

  })
}
