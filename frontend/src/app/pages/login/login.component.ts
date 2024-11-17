// login.component.ts
import { Component } from '@angular/core';
import { FormGroup, Validators, FormControl } from '@angular/forms';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})

export class LoginComponent {

  formulario: FormGroup;

  constructor(private authService: AuthService, private router: Router) {
    this.formulario = new FormGroup({
      email: new FormControl('', [Validators.required, Validators.email]),
      senha: new FormControl('', [Validators.required, Validators.minLength(4)]),
    });
  }


  onSubmit() {
    if (this.formulario.valid) {
      const email = this.formulario.get('email')?.value as string;
      const senha = this.formulario.get('senha')?.value as string;

      this.authService.login(email, senha).subscribe({
        next: (response) => {
          // Sucesso no login, redireciona para a página principal
          this.router.navigate(['/home']);
        },
        error: (err) => {
          console.error('Erro no login', err);
        }
      });
    }
  }
}
