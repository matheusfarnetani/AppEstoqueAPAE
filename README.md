# AppEstoqueAPAE

## Instruções para rodar a API:

### 1. Configurar arquivo .env:
```
./env.txt > .env
```
### 2. Criar banco de dados:
```
./src/data/schema.sql
```
### 3. Criar usuário administrador
```
node ./src/data/first_user.js
```

### 4. Popular Banco de dados
```
./src/data/inser_completo.sql
```

### 5. Adicionar Evento diário
```
./src/data/event_atualizar_status_estoque.sql
```