import { Component } from '@angular/core';

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
  // Verifica se existe uma confirmação no localStorage ao carregar a página
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
  // Recarrega a página para simular o envio do formulário
  location.reload();
  }
}
