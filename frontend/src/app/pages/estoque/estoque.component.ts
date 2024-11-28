import { Component, OnInit } from '@angular/core';
import { EstoqueService } from './estoque.service';
import { ItemEstoque } from './item-estoque';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { timeInterval, timeout } from 'rxjs';


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
  formularioRemove!: FormGroup;
quantidade: any;

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

    this.formularioRemove = this.fb.group({
      inputInsumoId: ['', Validators.required],
      inputQuantidade: ['', [Validators.required, Validators.min(1)]],
      inputDataSaida: ['', Validators.required],
      inputUnidadeMedida: ['', Validators.required],
      inputObservacoes: ['']
    });
    

    this.getEstoqueItems();

  }

  getEstoqueItems(): void {
    this.estoqueService.getItens().subscribe(
      (itens) => {
        this.estoqueItems = itens.estoque;
        this.quantidade = itens.estoque.length
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
          setTimeout(() => {
            this.isConfirmAddModal = false;
        }, 500);
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
  confirmarRemoveItem() {
    this.fecharRemoveItemModal()  // Abre o modal de confirmação
    this.isConfirmRemoveModal = true
    setTimeout(() => {
      this.isConfirmRemoveModal = false;
  }, 500);
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
    this.fecharRemoveItemModal();
  }

}
