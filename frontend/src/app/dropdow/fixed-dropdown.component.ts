// src/app/components/fixed-dropdown/fixed-dropdown.component.ts
import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-fixed-dropdown',
  templateUrl: './fixed-dropdown.component.html',
})
export class FixedDropdownComponent {
 @Output() onOptionSelected = new EventEmitter<string>();

  options = [
    { id: 1, name: 'Grama' },
    { id: 2, name: 'Quilograma' },
    { id: 3, name: 'Miligrama' },
    { id: 4, name: 'Litro' },
    { id: 5, name: 'Mililitro' },
    { id: 6, name: 'Unidade' },
    { id: 7, name: 'Pacote' },
    { id: 8, name: 'Caixa' },
    { id: 9, name: 'Garrafa' },
    { id: 10, name: 'Lata' },
    { id: 11, name: 'Saco' },
    { id: 12, name: 'Frasco' },
    { id: 13, name: 'Barra' },
    { id: 14, name: 'Pote' }
  ];

  selectedOption: string | null = null;

  onOptionChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    const selectedValue = target.value;
    this.selectedOption = selectedValue;
    this.onOptionSelected.emit(selectedValue); // Emite o valor para o componente pai
  }
}
