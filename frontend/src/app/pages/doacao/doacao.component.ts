// doacao.component.ts
import { Component, OnInit } from '@angular/core';
import { FormGroup, Validators, FormControl } from '@angular/forms';
import { DoaService } from './doacao.service'; // Atualize o caminho conforme necessário

@Component({
  selector: 'app-doacao',
  templateUrl: './doacao.component.html',
  styleUrls: ['./doacao.component.css']
})
export class DoacaoComponent implements OnInit {

  isModalOpen = false;
  isConfirmDonModal = false;
  errorMessage = '';
  successMessage = '';

  // Formulário de doação
  formulario = new FormGroup({
    id: new FormControl('', [Validators.required]),
    data: new FormControl('', [Validators.required]),
    desc: new FormControl('', [Validators.required]),
  });

name: any;

  constructor(private doaService: DoaService) {}

  ngOnInit(): void {
    this.name = localStorage.getItem('userName') ?? 'erro';

    if (localStorage.getItem('cadastroSucesso') === 'true') {
      this.isConfirmDonModal = true;
      localStorage.removeItem('cadastroSucesso');

      setTimeout(() => {
        this.isConfirmDonModal = false;
      }, 2000);
    }
  }

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

  confirmarDon(): void {
    if (this.formulario.invalid) {
      this.errorMessage = 'Por favor, preencha todos os campos obrigatórios.';
      return;
    }

    // Limpa mensagens anteriores
    this.errorMessage = '';
    this.successMessage = '';

    const { id, data, desc } = this.formulario.value;

    this.doaService.postDocao(id!, desc!, data!).subscribe({
      next: () => {
        this.successMessage = 'Doação salva com sucesso!';
        this.formulario.reset();
        this.isConfirmDonModal = true;
        localStorage.setItem('cadastroSucesso', 'true');

        setTimeout(() => {
          this.isConfirmDonModal = false;
        }, 2000);
      },
      error: (error: { message: string; }) => {
        this.errorMessage = error?.message || 'Erro ao salvar a doação.';
      }
    });
  }
}
