import { Component } from '@angular/core';
import { FormGroup, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-recsenha',
  templateUrl: './recsenha.component.html',
})
export class RecsenhaComponent {
  formulario = new FormGroup({
    email: new FormControl ('', [Validators.required, Validators.email]),
  })
}
