import { Component, OnInit } from '@angular/core';
import { EstoqueService } from './estoque.service';
import { ItemEstoque } from './item-estoque';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';


@Component({
  selector: 'app-estoque',
  templateUrl: './estoque.component.html',
  styleUrl: './estoque.component.css'
})

export class EstoqueComponent implements OnInit {
  isModalOpen = false;
  isAddItemModalOpen = false;
  isRemoveItemModalOpen = false;
  estoqueItems: ItemEstoque[] = [];
  addItemForm!: FormGroup;
  itemParaRemover: ItemEstoque | null = null;
  filtroSelecionado = 'nome'; // Opções: 'nome', 'validade', 'quantidade', 'status'
  pesquisa = '';
  isConfirmAddModal: any;
  isConfirmRemoveModal: any;
  formulario!: FormGroup<any>;
  name: string = 'name';

  constructor(private estoqueService: EstoqueService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.name = localStorage.getItem('userName') ?? 'erro';
    this.getEstoqueItems();
    this.addItemForm = this.fb.group({
      nome: ['', Validators.required],
      quantidade: ['', Validators.required],
      validade: ['', Validators.required],
      status: ['Aberto', Validators.required] // Valor padrão 'Aberto'
    });
  }

  getEstoqueItems(): void {
    this.estoqueService.getItens().subscribe(
      (itens) => {
        this.estoqueItems = itens.estoque;
        console.log(itens)
      },
      (error) => {
        console.error('Erro ao buscar itens do estoque:', error);
        // Trate o erro adequadamente, talvez exibindo uma mensagem na interface
      }
    );
  }

  confirmarRemoveItem(item: ItemEstoque) {
    this.itemParaRemover = item; // Define o item a ser removido
    this.abrirRemoveItemModal();  // Abre o modal de confirmação
  }

  abrirModal() {
    this.isModalOpen = true;
  }

  fecharModal() {
    this.isModalOpen = false;
  }


  abrirAddItemModal() {
    this.isAddItemModalOpen = true;
  }

  fecharAddItemModal() {
    this.isAddItemModalOpen = false;
  }

  abrirRemoveItemModal() {
    this.isRemoveItemModalOpen = true;
  }

  fecharRemoveItemModal() {
    this.isRemoveItemModalOpen = false;
  }

  removerItemDoEstoque() {
    if (this.itemParaRemover) {
      this.estoqueService.deleteItem(this.itemParaRemover.id).subscribe(
        () => {
          console.log('Item removido com sucesso!');
          this.getEstoqueItems(); // Atualiza a lista após a remoção
          this.fecharRemoveItemModal();
          this.itemParaRemover = null; // Limpa a variável
        },
        (error) => {
          console.error('Erro ao remover item:', error);
          // Lide com o erro de forma apropriada
        }
      );
    }
  }

  confirmarAddItem(): void {
    if (this.addItemForm.valid) {
      this.estoqueService.createItem(this.addItemForm.value).subscribe(
        () => {
          this.getEstoqueItems(); // Atualiza a lista após a adição
          this.addItemForm.reset(); // Limpa o formulário
          this.fecharAddItemModal();
        },
        (error) => {
          console.error('Erro ao adicionar item:', error);
          // Lide com o erro de forma apropriada
        }
      );
    }


  }

  getFilteredItems(): ItemEstoque[] {
    if (!this.pesquisa || !this.filtroSelecionado) {
      return this.estoqueItems;
    }
    const pesquisaLower = this.pesquisa.toLowerCase();
    return this.estoqueItems.filter(item => {
      const fieldValue = (item as any)[this.filtroSelecionado]?.toString().toLowerCase();
      return fieldValue.includes(pesquisaLower);
    });
  }



}
