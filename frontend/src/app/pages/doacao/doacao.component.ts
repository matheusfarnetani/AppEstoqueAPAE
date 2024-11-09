import { Component } from '@angular/core';

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
    // Verifica se existe uma confirmação no localStorage ao carregar a página
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
    // Recarrega a página para simular o envio do formulário
    location.reload();
    }
  }
