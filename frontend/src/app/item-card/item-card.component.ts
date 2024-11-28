// src/app/item-card/item-card.component.ts
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-item-card',
  templateUrl: './item-card.component.html',
  styleUrls: ['./item-card.component.css']
})

export class ItemCardComponent {
  @Input() item: any;

  // Mapeia os rótulos e classes de status
  getStatusLabel(status: number): { label: string; class: string } {
    switch (status) {
      case 0:
        return { label: 'Fechado', class: 'fechado' };
      case 1:
        return { label: 'Aberto', class: 'aberto' };
      case 2:
        return { label: 'Consumido', class: 'consumido' };
      case 3:
        return { label: 'Vence hoje', class: 'vence-hoje' };
      case 4:
        return { label: 'Vencido', class: 'vencido' };
      default:
        return { label: 'Desconhecido', class: 'desconhecido' };
    }
  }
}
