import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-adminuser',
  templateUrl: './adminuser.component.html',
  styleUrl: './adminuser.component.css'
})
export class AdminuserComponent {

  isModalOpen = false;
  isConfirmUserModal = false;

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

  ngOnInit(): void {
    if (localStorage.getItem('cadastroSucesso') === 'true') {
      this.isConfirmUserModal = true;
      localStorage.removeItem('cadastroSucesso');
  
  
    setTimeout(() => {
      this.isConfirmUserModal = false;
     },2000)
    }
  }
  
  
  confirmarUserDonation(): void {
    localStorage.setItem('cadastroSucesso', 'true');
    location.reload();
    }


    formulario = new FormGroup({
      nome: new FormControl ('', [Validators.required]),
      senha: new FormControl ('', [Validators.required, Validators.minLength(4)]),
      data: new FormControl ('', [Validators.required]),
      email: new FormControl ('', [Validators.required, Validators.email]),
      telefone: new FormControl ('', [Validators.required]),
      cpf: new FormControl ('', [Validators.required]),
    })
  }

