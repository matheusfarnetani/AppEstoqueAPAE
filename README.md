# Projeto de Gerenciamento de Estoque para a Apae de São João da Boa Vista

Este repositório faz parte de um projeto desenvolvido como trabalho de faculdade, em parceria com a ONG Apae de São João da Boa Vista. A iniciativa tem como objetivo criar um aplicativo para automatizar o gerenciamento do estoque de insumos utilizados na alimentação dos alunos da escola, oferecendo lanches e almoços. Este software surge da necessidade de controle rigoroso das datas de validade dos insumos, garantindo a qualidade e segurança dos alimentos fornecidos.

Para atender a essa demanda, desenvolvemos um banco de dados MySQL robusto, com diversas automatizações como triggers, procedures, functions e events, que garantem o controle das datas de validade e a movimentação dos itens no estoque. A aplicação consiste em três componentes principais:

- **Backend**: Uma API desenvolvida em Node.js, responsável pela comunicação com o banco de dados e pelas lógicas do sistema.
- **Frontend**: Uma interface web criada em Angular 17, que permite aos usuários interagirem de forma intuitiva com o sistema de gerenciamento de estoque.
- **Database**: Um banco de dados MySQL que armazena todas as informações relacionadas aos insumos, incluindo suas datas de validade e status no estoque.

## Estrutura do Repositório

- **database/**: Contém os scripts SQL para criação das tabelas, triggers, procedures, functions e events.
- **backend/**: Implementação da API em Node.js, seguindo o padrão MVC (Model-View-Controller) para garantir a organização e manutenção do código.
- **frontend/**: Código do aplicativo web desenvolvido em Angular 17.

## Como Executar o Projeto

Para executar o projeto localmente, siga os seguintes passos:

### 1. Clone o Repositório

Clone o repositório para sua máquina local usando o comando:

```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
```

### 2. Banco de Dados

1. Navegue até a pasta `database` e execute os scripts SQL no seu servidor MySQL para criar o banco de dados e configurar todas as tabelas e automatizações.
2. Certifique-se de que o MySQL está rodando e configurado corretamente.

### 3. Backend (API)

1. Navegue até a pasta `backend`.
2. Instale as dependências necessárias utilizando o npm:

```bash
npm install
```

3. Configure as variáveis de ambiente para a conexão com o banco de dados (pode ser criado um arquivo `.env` com as credenciais).
4. Inicie o servidor Node.js:

```bash
npm start
```

### 4. Frontend

1. Navegue até a pasta `frontend`.
2. Instale as dependências necessárias utilizando o npm:

```bash
npm install
```

3. Inicie o servidor de desenvolvimento do Angular:

```bash
ng serve
```

4. Acesse a aplicação no navegador pelo endereço `http://localhost:4200`.

## Instruções para Rodar a API Completamente

### 1. Configurar arquivo .env:

```bash
./env.txt > .env
```

### 2. Criar Banco de Dados:

```bash
./database/schema.sql
```

### 3. Criar Usuário Administrador

```bash
node ./database/first_user.js
```

### 4. Popular Banco de Dados

```bash
./database/insert_completo.sql
```

### 5. Adicionar Evento Diário

```bash
./database/event_atualizar_status_estoque.sql
```

## Funcionalidades Principais

- **Controle de Estoque**: Visualização dos itens em estoque, com destaque para itens próximos da data de validade.
- **Automatização de Processos**: A utilização de triggers e events garante que itens vencidos sejam movidos para a tabela correta, facilitando o controle.
- **Interface Amigável**: A interface desenvolvida em Angular permite uma navegação intuitiva para os usuários da ONG.

## Diagramas

Em breve, serão adicionados diagramas para melhor ilustrar a estrutura do projeto. Pretendemos incluir um diagrama explicando o modelo lógico do banco de dados, para ajudar a compreender como as tabelas estão relacionadas e como ocorre a gestão dos insumos.

## Licença

Este projeto é de uso interno da Apae de São João da Boa Vista e está sendo desenvolvido para fins acadêmicos.

