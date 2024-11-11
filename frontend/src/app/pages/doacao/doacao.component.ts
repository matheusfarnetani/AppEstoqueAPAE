import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-doacao',
  templateUrl: './doacao.component.html',
  styleUrl: './doacao.component.css'
})
export class DoacaoComponent {

  isModalOpen = false;
  isConfirmDonModal = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

  ngOnInit(): void {
    if (localStorage.getItem('cadastroSucesso') === 'true') {
      this.isConfirmDonModal = true;
      localStorage.removeItem('cadastroSucesso');
  
  
    setTimeout(() => {
      this.isConfirmDonModal = false;
     },2000)
    }
  }
  
  
  confirmarDon(): void {
    localStorage.setItem('cadastroSucesso', 'true');
    location.reload();
    }


    formulario = new FormGroup({
      id: new FormControl ('', [Validators.required]),
      data: new FormControl ('', [Validators.required]),
      desc: new FormControl ('', [Validators.required]),
    })
  }
