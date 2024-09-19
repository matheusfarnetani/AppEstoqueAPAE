-- Variavel de Sessão
SET @user_id = -1;

-- Unidades de medida
INSERT INTO `db_apae_estoque`.`unidades_medida` (`id`, `nome`)
VALUES
(1, 'grama'),
(2, 'quilograma'),
(3, 'miligrama'),
(4, 'litro'),
(5, 'mililitro'),
(6, 'unidade'),
(7, 'pacote'),
(8, 'caixa'),
(9, 'garrafa'),
(10, 'lata'),
(11, 'saco'),
(12, 'frasco'),
(13, 'barra'),
(14, 'pote');

-- Inserindo categorias na tabela `categoria_insumos`
INSERT INTO `db_apae_estoque`.`categoria_insumos` (`nome`)
VALUES
('Cereais'),
('Grãos'),
('Leguminosas'),
('Frutas'),
('Verduras'),
('Legumes'),
('Carnes'),
('Ovos'),
('Laticínios'),
('Oleaginosas'),
('Sementes'),
('Gorduras'),
('Óleos'),
('Açúcares'),
('Doces'),
('Bebidas'),
('Condimentos'),
('Especiarias');

-- Inserindo insumos na tabela `insumos`
-- Cereais
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Arroz', 1, NULL),
('Milho', 1, NULL),
('Trigo', 1, NULL);

-- Grãos
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Feijão', 2, NULL),
('Soja', 2, NULL),
('Grão-de-bico', 2, NULL);

-- Leguminosas
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Lentilha', 3, NULL),
('Ervilha', 3, NULL),
('Fava', 3, NULL);

-- Frutas
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Maçã', 4, NULL),
('Banana', 4, NULL),
('Laranja', 4, NULL);

-- Verduras
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Alface', 5, NULL),
('Espinafre', 5, NULL),
('Rúcula', 5, NULL);

-- Legumes
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Cenoura', 6, NULL),
('Brócolis', 6, NULL),
('Batata', 6, NULL);

-- Carnes
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Carne Bovina', 7, NULL),
('Carne de Frango', 7, NULL),
('Carne Suína', 7, NULL);

-- Ovos
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Ovo de Galinha', 8, NULL),
('Ovo de Codorna', 8, NULL),
('Ovo de Pato', 8, NULL);

-- Laticínios
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Leite Integral', 9, NULL),
('Queijo Muçarela', 9, NULL),
('Iogurte Natural', 9, NULL);

-- Oleaginosas
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Castanha-do-Pará', 10, NULL),
('Nozes', 10, NULL),
('Amêndoas', 10, NULL);

-- Sementes
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Semente de Chia', 11, NULL),
('Semente de Linhaça', 11, NULL),
('Semente de Girassol', 11, NULL);

-- Gorduras
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Azeite de Oliva', 12, NULL),
('Óleo de Soja', 12, NULL),
('Óleo de Milho', 12, NULL);

-- Óleos
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Margarina', 13, NULL),
('Banha de Porco', 13, NULL),
('Gordura Vegetal', 13, NULL);

-- Açúcares
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Açúcar Refinado', 14, NULL),
('Açúcar Mascavo', 14, NULL),
('Mel', 14, NULL);

-- Doces
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Chocolate', 15, NULL),
('Balas', 15, NULL),
('Biscoitos', 15, NULL);

-- Bebidas
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Suco de Laranja', 16, NULL),
('Refrigerante', 16, NULL),
('Água Mineral', 16, NULL);

-- Condimentos
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Sal', 17, NULL),
('Pimenta', 17, NULL),
('Alho', 17, NULL);

-- Especiarias
INSERT INTO `db_apae_estoque`.`insumos` (`nome`, `categoria_insumos_id`, `observacoes`)
VALUES
('Canela', 18, NULL),
('Cravo', 18, NULL),
('Cominho', 18, NULL);

-- Inserindo endereços na tabela `endereco`
INSERT INTO `db_apae_estoque`.`endereco` (`tipo`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `cep`)
VALUES
('Residencial', 'Rua das Flores', '123', 'Apt 101', 'Jardim Primavera', 'São Paulo', 'SP', '01234567'),
('Comercial', 'Avenida Paulista', '987', 'Sala 202', 'Bela Vista', 'São Paulo', 'SP', '01310940'),
('Residencial', 'Rua dos Pinheiros', '456', NULL, 'Pinheiros', 'São Paulo', 'SP', '05422012'),
('Comercial', 'Avenida Brasil', '2345', 'Loja 5', 'Jardim América', 'Rio de Janeiro', 'RJ', '22250040'),
('Residencial', 'Rua das Acácias', '789', 'Casa', 'Centro', 'Curitiba', 'PR', '80010000'),
('Comercial', 'Rua XV de Novembro', '101', NULL, 'Centro', 'Curitiba', 'PR', '80020010'),
('Residencial', 'Avenida Atlântica', '456', NULL, 'Copacabana', 'Rio de Janeiro', 'RJ', '22070001'),
('Comercial', 'Avenida Rio Branco', '300', 'Sala 15', 'Centro', 'Rio de Janeiro', 'RJ', '20040001'),
('Residencial', 'Rua Augusta', '789', 'Apt 302', 'Consolação', 'São Paulo', 'SP', '01305000'),
('Comercial', 'Avenida Getúlio Vargas', '456', 'Loja 12', 'Funcionários', 'Belo Horizonte', 'MG', '30112001');

-- Inserindo telefones na tabela `telefone`
INSERT INTO `db_apae_estoque`.`telefone` (`tipo`, `ddi`, `ddd`, `numero`)
VALUES
('fixo', '+55', '11', '34567890'),
('celular', '+55', '11', '987654321'),
('fixo', '+55', '21', '23456789'),
('celular', '+55', '21', '998877665'),
('fixo', '+55', '41', '33445566'),
('celular', '+55', '41', '912345678'),
('fixo', '+55', '31', '22334455'),
('celular', '+55', '31', '998877665'),
('fixo', '+55', '51', '33445566'),
('celular', '+55', '51', '912345678'),
('fixo', '+55', '71', '22334455'),
('celular', '+55', '71', '987654321');

-- Inserção de pessoas físicas com novos CPFs válidos
INSERT INTO `db_apae_estoque`.`pessoas` (`tipo_pessoa`, `nome`, `documento`, `data_nascimento`, `email`, `endereco_id`)
VALUES
(0, 'João da Silva', '67021443005', '1980-05-15', 'joao.silva@example.com', 1),
(0, 'Maria Oliveira', '94905336023', '1975-03-22', 'maria.oliveira@example.com', 2),
(0, 'Carlos Souza', '13934437028', '1990-07-08', 'carlos.souza@example.com', 3),
(0, 'Ana Costa', '37489564018', '1985-10-10', 'ana.costa@example.com', 4),
(0, 'Paulo Lima', '48446983036', '1992-11-25', 'paulo.lima@example.com', 5);

-- Inserção de pessoas jurídicas
INSERT INTO `db_apae_estoque`.`pessoas` (`tipo_pessoa`, `nome`, `documento`, `data_nascimento`, `email`, `endereco_id`)
VALUES
(1, 'Empresa ABC Ltda', '95163056000173', '2005-09-12', 'contato@empresaabc.com.br', 6),
(1, 'Indústria XYZ S.A.', '13207455000124', '1998-06-30', 'contato@industriaxyz.com.br', 7),
(1, 'Comércio Beta Ltda', '67472714000173', '2010-01-19', 'contato@comerciobeta.com.br', 8),
(1, 'Serviços Delta ME', '76183697000145', '2015-04-07', 'contato@servicosdelta.com.br', 9),
(1, 'Construtora Gamma S.A.', '13289874000152', '2000-12-05', 'contato@construtoragamma.com.br', 10);

-- Relacionamento de pessoas físicas com telefones
INSERT INTO `db_apae_estoque`.`pessoa_has_telefone` (`pessoa_id`, `telefone_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6); -- João da Silva possui dois números de telefone

-- Relacionamento de pessoas jurídicas com telefones
INSERT INTO `db_apae_estoque`.`pessoa_has_telefone` (`pessoa_id`, `telefone_id`)
VALUES
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 11),
(6, 12); -- Empresa ABC Ltda possui dois números de telefone

-- Inserção na tabela de doações
INSERT INTO `db_apae_estoque`.`doacoes` (`pessoas_id`, `descricao`, `data_doacao`)
VALUES
(1, 'Doação de arroz e feijão', '2023-08-01'),
(1, 'Doação de leite e derivados', '2023-08-15'),
(2, 'Doação de frutas e legumes', '2023-09-05'),
(2, 'Doação de carnes e ovos', '2023-09-10'),
(3, 'Doação de óleo de soja e azeite', '2023-12-01'),
(4, 'Doação de cereais e grãos', '2024-01-20'),
(5, 'Doação de açúcares e doces', '2024-02-15'),
(5, 'Doação de condimentos e especiarias', '2024-02-20');

INSERT INTO `db_apae_estoque`.`doacoes` (`pessoas_id`, `descricao`, `data_doacao`)
VALUES
(3, 'Doação de massas e pães', '2024-03-01'),
(4, 'Doação de sucos e bebidas', '2024-04-10'),
(1, 'Doação de verduras e hortaliças', '2024-05-05'),
(2, 'Doação de laticínios e queijos', '2024-06-01');

-- Inserção na tabela de usuários
-- INSERT INTO `db_apae_estoque`.`usuarios` (`username`, `senha`, `email`, `funcao`)
-- VALUES
-- ('admin01', SHA2('senhaAdmin123', 256), 'admin01@example.com', 'administrador'),
-- ('nutri01', SHA2('senhaNutri123', 256), 'nutri01@example.com', 'nutricionista'),
-- ('cozinheiro01', SHA2('senhaCozinha123', 256), 'cozinheiro01@example.com', 'cozinheiro');

-- Pedidos
INSERT INTO `db_apae_estoque`.`pedidos` (`usuarios_id`, `pessoas_id`, `descricao`, `data_pedido`)
VALUES 
(1, 1, 'Pedido de arroz e feijão', '2023-08-01'),
(1, 1, 'Pedido de leite e derivados', '2023-08-15'),
(1, 2, 'Pedido de frutas e legumes', '2023-09-05'),
(1, 2, 'Pedido de carnes e ovos', '2023-09-10'),
(1, 3, 'Pedido de óleo de soja e azeite', '2023-12-01'),
(1, 4, 'Pedido de cereais e grãos', '2024-01-20'),
(1, 5, 'Pedido de açúcares e doces', '2024-02-15'),
(1, 5, 'Pedido de condimentos e especiarias', '2024-02-20'),
(1, 3, 'Pedido de massas e pães', '2024-03-01'),
(1, 4, 'Pedido de sucos e bebidas', '2024-04-10'),
(1, 1, 'Pedido de verduras e hortaliças', '2024-05-05'),
(1, 2, 'Pedido de laticínios e queijos', '2024-06-01');

-- Associação entre doações e pedidos
INSERT INTO `db_apae_estoque`.`doacoes_has_pedidos` (`doacoes_id`, `pedidos_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Inserindo itens de pedido na tabela `itens_pedido`
INSERT INTO `db_apae_estoque`.`itens_pedido` (`pedidos_id`, `insumos_id`, `quantidade`, `unidades_medida_id`)
VALUES 
(1, 1, 20.00, 2),  -- Arroz
(1, 4, 10.00, 2),  -- Feijão
(2, 25, 50.00, 4),  -- Leite Integral
(2, 26, 20.00, 2),  -- Queijo Muçarela
(3, 10, 30.00, 6),  -- Maçã
(3, 17, 20.00, 2),  -- Brócolis
(4, 19, 50.00, 2),  -- Carne Bovina
(4, 22, 100.00, 6),  -- Ovo de Galinha
(5, 35, 30.00, 4),  -- Óleo de Soja
(5, 34, 50.00, 4),  -- Azeite de Oliva
(6, 2, 40.00, 2),  -- Milho
(6, 6, 25.00, 2),  -- Grão-de-bico
(7, 41, 50.00, 2),  -- Açúcar Mascavo
(7, 45, 10.00, 10),  -- Biscoitos
(8, 51, 20.00, 2),  -- Alho
(8, 53, 15.00, 2),  -- Cravo
(9, 3, 30.00, 2),  -- Trigo
(9, 7, 20.00, 2),  -- Lentilha
(10, 46, 100.00, 4),  -- Suco de Laranja
(10, 48, 200.00, 4),  -- Água Mineral
(11, 14, 50.00, 2),  -- Espinafre
(11, 17, 40.00, 2),  -- Brócolis
(12, 25, 70.00, 4),  -- Leite Integral
(12, 26, 50.00, 2);  -- Queijo Muçarela

-- Inserindo itens na tabela `estoque_entrada`
INSERT INTO `db_apae_estoque`.`estoque_entrada` (`insumos_id`, `doacoes_id`, `quantidade`, `unidades_medida_id`, `data_validade`)
VALUES 
(1, 1, 20.00, 2, '2024-08-01'),  -- Arroz (Doação 1)
(4, 1, 10.00, 2, '2024-08-01'),  -- Feijão (Doação 1)
(25, 2, 50.00, 4, '2024-08-15'),  -- Leite Integral (Doação 2)
(26, 2, 20.00, 2, '2024-08-15'),  -- Queijo Muçarela (Doação 2)
(10, 3, 30.00, 6, '2024-09-05'),  -- Maçã (Doação 3)
(17, 3, 20.00, 2, '2024-09-05'),  -- Brócolis (Doação 3)
(19, 4, 50.00, 2, '2024-09-10'),  -- Carne Bovina (Doação 4)
(22, 4, 100.00, 6, '2024-09-10'),  -- Ovo de Galinha (Doação 4)
(35, 5, 30.00, 4, '2024-12-01'),  -- Óleo de Soja (Doação 5)
(34, 5, 50.00, 4, '2024-12-01'),  -- Azeite de Oliva (Doação 5)
(2, 6, 40.00, 2, '2024-01-20'),  -- Milho (Doação 6)
(6, 6, 25.00, 2, '2024-01-20'),  -- Grão-de-bico (Doação 6)
(41, 7, 50.00, 2, '2024-02-15'),  -- Açúcar Mascavo (Doação 7)
(45, 7, 10.00, 10, '2024-02-15'),  -- Biscoitos (Doação 7)
(51, 8, 20.00, 2, '2024-02-20'),  -- Alho (Doação 8)
(53, 8, 15.00, 2, '2024-02-20');  -- Cravo (Doação 8)

-- Alterar o status para "Consumido" (2)
CALL proc_atualizar_e_mover_estoque(3, 2, 'Insumo consumido');
CALL proc_atualizar_e_mover_estoque(5, 2, 'Insumo consumido');

-- Alterar o status para "Vence hoje" (3)
CALL proc_atualizar_e_mover_estoque(7, 3, 'Insumo vence hoje');

-- Alterar o status para "Vencido" (4)
CALL proc_atualizar_e_mover_estoque(8, 4, 'Insumo vencido');
CALL proc_atualizar_e_mover_estoque(10, 4, 'Insumo vencido');

-- Alterar o status para "Aberto" (1)
CALL proc_atualizar_e_mover_estoque(2, 1, 'Insumo aberto');
CALL proc_atualizar_e_mover_estoque(6, 1, 'Insumo aberto');
