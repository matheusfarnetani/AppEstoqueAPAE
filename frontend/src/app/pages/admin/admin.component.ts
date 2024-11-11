import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css'
})

export class AdminComponent {

  isModalOpen = false;
  isConfirmDonationModal = false;

  

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }


 ngOnInit(): void {
  if (localStorage.getItem('cadastroSucesso') === 'true') {
    this.isConfirmDonationModal = true;
    localStorage.removeItem('cadastroSucesso');


  setTimeout(() => {
    this.isConfirmDonationModal = false;
   },2000)
  }
}


confirmarCadDonation(): void {
  localStorage.setItem('cadastroSucesso', 'true');
  location.reload();
  }


  formulario = new FormGroup({
    nome: new FormControl ('', [Validators.required]),
    cpf: new FormControl ('', [Validators.required]),
    data: new FormControl ('', [Validators.required]),
    telefone: new FormControl ('', [Validators.required]),
    end: new FormControl ('', [Validators.required]),
    cidade: new FormControl ('', [Validators.required]),
    email: new FormControl ('', [Validators.required, Validators.email]),
  })
}
