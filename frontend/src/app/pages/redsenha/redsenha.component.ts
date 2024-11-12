import { Component } from '@angular/core';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { FormControl } from '@angular/forms';


@Component({
  selector: 'app-redsenha',
  templateUrl: './redsenha.component.html',
})
export class RedsenhaComponent {
  formulario: FormGroup;

  constructor(private fb: FormBuilder) {
    // Criando o formulário com os campos senha e confirmarSenha
    this.formulario = this.fb.group(
      {
        senha: new FormControl('', [
          Validators.required,
          Validators.minLength(4)  // Validação para comprimento mínimo de 4 caracteres
        ]),
        confirmarSenha: new FormControl('', [
          Validators.required
        ])
      },
      {
        validators: this.senhasIguaisValidator  // Validação personalizada para comparar as senhas
      }
    );
  }

  // Validador personalizado para comparar as senhas
  senhasIguaisValidator(formGroup: FormGroup): { [key: string]: boolean } | null {
    const senha = formGroup.get('senha')?.value;
    const confirmarSenha = formGroup.get('confirmarSenha')?.value;

    return senha && confirmarSenha && senha !== confirmarSenha ? { senhasNaoIguais: true } : null;
  }
}
