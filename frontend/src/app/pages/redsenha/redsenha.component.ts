import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-redsenha',
  templateUrl: './redsenha.component.html',
  styleUrl: './redsenha.component.css'
})
export class RedsenhaComponent {
  formulario = new FormGroup({
    senha: new FormControl ('', [Validators.required, Validators.minLength(4)]),
  })
}
