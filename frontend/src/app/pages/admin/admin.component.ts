import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AdminService } from './admin.server';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css'] // Corrected to styleUrls
})
export class AdminComponent implements OnInit {
  isModalOpen = false;
  isConfirmDonationModal = false;
  errorMessage = '';

  formulario = new FormGroup({
    tipo_pessoa: new FormControl('', [Validators.required]),
    nome: new FormControl('', [Validators.required]),
    cpf: new FormControl('', [Validators.required]),
    data: new FormControl('', [Validators.required]),
    telefone: new FormControl('', [Validators.required]),
    end: new FormControl('', [Validators.required]),
    cidade: new FormControl('', [Validators.required]),
    email: new FormControl('', [Validators.required, Validators.email]),
  });
name: any;
  
  constructor(private adminService: AdminService) {}

  ngOnInit(): void {
    this.name = localStorage.getItem('userName') ?? 'erro';

    if (localStorage.getItem('cadastroSucesso') === 'true') {
      this.isConfirmDonationModal = true;
      localStorage.removeItem('cadastroSucesso');

      setTimeout(() => {
        this.isConfirmDonationModal = false;
      }, 2000);
    }
  }

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

  confirmarCadDonation(): void {
    if (this.formulario.invalid) {
      this.errorMessage = 'Por favor, preencha todos os campos obrigatórios.';
      return;
    }

    // Clear previous error message
    this.errorMessage = '';

    // Extract values
    const tipo_pessoa = this.formulario.get('tipo_pessoa')?.value ?? ''; // Access the value
    const nome = this.formulario.get('nome')?.value ?? ''; // Access the value
    const cpf = this.formulario.get('cpf')?.value ?? ''; // Access the value
    const data = this.formulario.get('data')?.value ?? ''; // Access the value
    const email = this.formulario.get('email')?.value ?? ''; // Access the value
    const end = this.formulario.get('end')?.value ?? ''; // Access the value
    const cidade = this.formulario.get('cidade')?.value ?? ''; // Access the value
    
    const endereco_id = `${end}${cidade}`;

    this.adminService.cadDoador(tipo_pessoa, nome, cpf, data, email, endereco_id).subscribe({
      next: () => {
        localStorage.setItem('cadastroSucesso', 'true');
        this.formulario.reset(); // Reset the form after successful submission
        this.isConfirmDonationModal = true; // Show confirmation modal
        setTimeout(() => {
          this.isConfirmDonationModal = false;
        }, 2000);
      },
      error: (error: { message: string }) => {
        this.errorMessage = error?.message || 'Erro ao salvar a doação.';
      }
    });
  }
}
