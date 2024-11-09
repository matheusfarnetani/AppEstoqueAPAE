import { Component } from '@angular/core';

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
    // Verifica se existe uma confirmação no localStorage ao carregar a página
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
    // Recarrega a página para simular o envio do formulário
    location.reload();
    }
  }

