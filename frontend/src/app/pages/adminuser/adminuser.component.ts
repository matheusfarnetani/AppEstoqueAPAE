// src/app/adminuser/adminuser.component.ts
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AdminService } from './adminuser.service';

@Component({
  selector: 'app-adminuser',
  templateUrl: './adminuser.component.html',
  styleUrls: ['./adminuser.component.css']
})
export class AdminuserComponent implements OnInit {
  isModalOpen = false;
  isConfirmUserModal = false;
  formulario: FormGroup;
name: any;

  constructor(private adminService: AdminService) {
    this.formulario = new FormGroup({
      nome: new FormControl('', [Validators.required]),
      senha: new FormControl('', [Validators.required, Validators.minLength(4)]),
      data: new FormControl('', [Validators.required]),
      email: new FormControl('', [Validators.required, Validators.email]),
      telefone: new FormControl('', [Validators.required]),
      cpf: new FormControl('', [Validators.required]),
    });
  }

  ngOnInit(): void {
    this.name = localStorage.getItem('userName') ?? 'erro';

    if (localStorage.getItem('cadastroSucesso') === 'true') {
      this.isConfirmUserModal = true;
      localStorage.removeItem('cadastroSucesso');

      setTimeout(() => {
        this.isConfirmUserModal = false;
      }, 2000);
    }
  }

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }

  confirmarUserDonation(): void {
    if (this.formulario.valid) {
      const formData = this.formulario.value;

      this.adminService.createUser({
        username: formData.nome,
        password: formData.senha,
        email: formData.email,
        funcao: 'admin', // Pode ser parametrizado se necessário
      }).subscribe({
        next: (response) => {
          console.log('User created successfully:', response);
          localStorage.setItem('cadastroSucesso', 'true');
          this.isConfirmUserModal = true;
          this.formulario.reset();
        },
        error: (error) => {
          console.error('Error while creating user:', error.message);
        }
      });
    } else {
      console.warn('Form is invalid');
    }
  }
}
