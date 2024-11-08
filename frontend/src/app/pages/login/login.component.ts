import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  formulario = new FormGroup({
    email: new FormControl ('', [Validators.required, Validators.email]),
    senha: new FormControl('', [Validators.required, Validators.min(4), Validators.max(8)]),
  })
}
