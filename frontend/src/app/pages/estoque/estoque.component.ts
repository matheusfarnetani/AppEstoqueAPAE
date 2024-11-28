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
  formulario!: FormGroup; // Formulário atualizado
  itemParaRemover: ItemEstoque | null = null;
  filtroSelecionado = 'nome';
  pesquisa = '';
  isConfirmAddModal = false;
  isConfirmRemoveModal = false;
  name: string = 'name';

  constructor(private estoqueService: EstoqueService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.name = localStorage.getItem('userName') ?? 'erro';

    this.formulario = this.fb.group({
      insumos_id: ['', Validators.required], // ID do Insumo
      doacoes_id: ['', Validators.required], // ID da Doação
      quantidade: ['', [Validators.required, Validators.min(1)]], // Quantidade
      unidades_medida_id: ['', Validators.required], // Unidade de Medida
      data_validade: ['', Validators.required], // Data de Validade
      dataentrada: ['', Validators.required]
    });

    this.getEstoqueItems();
    
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

  confirmarAddItem(): void {
    if (this.formulario.valid) {
      const formValue = this.formulario.value;

      const novoItem = {
        insumos_id: parseInt(formValue.insumos_id, 10), // Converte para número
        doacoes_id: parseInt(formValue.doacoes_id, 10), // Converte para número
        quantidade: formValue.quantidade, // Já é número por validação do formulário
        unidades_medida_id: parseInt(formValue.unidades_medida_id, 10), // Converte para número
        data_validade: formValue.data_validade, // Permanece como string
      };

      this.estoqueService.createItem(novoItem).subscribe(
        (response) => {
          console.log('Item adicionado com sucesso!', response);
          this.getEstoqueItems(); // Atualiza a lista de itens
          this.formulario.reset(); // Reseta o formulário
          this.fecharAddItemModal(); // Fecha o modal
          this.isConfirmAddModal = true; // Exibe mensagem de sucesso
        },
        (error) => {
          console.error('Erro ao adicionar item:', error);
          alert('Falha ao adicionar o item. Verifique os dados e tente novamente.');
        }
      );
    } else {
      alert('Por favor, preencha todos os campos obrigatórios.');
    }
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
