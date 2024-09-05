-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_apae_estoque
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_apae_estoque
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_apae_estoque` DEFAULT CHARACTER SET utf8 ;
USE `db_apae_estoque` ;

-- -----------------------------------------------------
-- Table `db_apae_estoque`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `funcao` ENUM("administrador", "nutricionista", "cozinheiro", "professor", "monitor") NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NULL,
  `logradouro` VARCHAR(60) NULL,
  `numero` VARCHAR(10) NULL,
  `complemento` VARCHAR(30) NULL,
  `bairro` VARCHAR(60) NULL,
  `cidade` VARCHAR(60) NULL,
  `estado` CHAR(2) NULL,
  `cep` CHAR(8) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`pessoas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`pessoas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_pessoa` TINYINT(1) NOT NULL,
  `nome` VARCHAR(150) NOT NULL,
  `documento` CHAR(14) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco1_idx` (`endereco_id` ASC) VISIBLE,
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `db_apae_estoque`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM("fixo", "celular") NULL,
  `ddi` VARCHAR(5) NULL,
  `ddd` CHAR(3) NULL,
  `numero` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`categoria_insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`categoria_insumos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`insumos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `categoria_insumos_id` INT NOT NULL,
  `observacoes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_insumos_categoria_insumos1_idx` (`categoria_insumos_id` ASC) VISIBLE,
  CONSTRAINT `fk_insumos_categoria_insumos1`
    FOREIGN KEY (`categoria_insumos_id`)
    REFERENCES `db_apae_estoque`.`categoria_insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`doacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoas_id` INT NOT NULL,
  `descricao` TEXT NULL,
  `data_doacao` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_doacoes_pessoas1_idx` (`pessoas_id` ASC) VISIBLE,
  CONSTRAINT `fk_doacoes_pessoas1`
    FOREIGN KEY (`pessoas_id`)
    REFERENCES `db_apae_estoque`.`pessoas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  `pessoas_id` INT NOT NULL,
  `descricao` TEXT NULL,
  `data_pedido` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_pessoas1_idx` (`pessoas_id` ASC) VISIBLE,
  INDEX `fk_pedidos_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_pessoas1`
    FOREIGN KEY (`pessoas_id`)
    REFERENCES `db_apae_estoque`.`pessoas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `db_apae_estoque`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`unidades_medida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`unidades_medida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`itens_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`itens_pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedidos_id` INT NOT NULL,
  `insumos_id` INT NOT NULL,
  `quantidade` DECIMAL(10,2) NULL,
  `unidades_medida_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itens_pedido_pedidos1_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_itens_pedido_insumos1_idx` (`insumos_id` ASC) VISIBLE,
  INDEX `fk_itens_pedido_unidades_medida1_idx` (`unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_itens_pedido_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `db_apae_estoque`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_pedido_insumos1`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_pedido_unidades_medida1`
    FOREIGN KEY (`unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`unidades_medida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`estoque_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`estoque_entrada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `insumos_id` INT NOT NULL,
  `doacoes_id` INT NULL DEFAULT NULL,
  `quantidade` DECIMAL(10,2) NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_validade` DATE NULL,
  `data_entrada` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_itens_doacao_insumos1_idx` (`insumos_id` ASC) VISIBLE,
  INDEX `fk_estoque_entrada_unidades_medida1_idx` (`unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_itens_doacao_insumos1`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_entrada_unidades_medida1`
    FOREIGN KEY (`unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`unidades_medida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`estoque` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `insumos_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Fechado = 0\nAberto = 1\nConsumido = 2\nVence hoje = 3\nVencido = 4',
  `data_validade` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_insumos1_idx` (`insumos_id` ASC) VISIBLE,
  INDEX `fk_estoque_unidades_medida1_idx` (`unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_insumos1`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_unidades_medida1`
    FOREIGN KEY (`unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`unidades_medida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`pessoa_has_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`pessoa_has_telefone` (
  `pessoa_id` INT NOT NULL,
  `telefone_id` INT NOT NULL,
  PRIMARY KEY (`pessoa_id`, `telefone_id`),
  INDEX `fk_pessoa_fisica_has_telefone_telefone1_idx` (`telefone_id` ASC) VISIBLE,
  INDEX `fk_pessoa_fisica_has_telefone_pessoa_fisica1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_fisica_has_telefone_pessoa_fisica1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `db_apae_estoque`.`pessoas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_fisica_has_telefone_telefone1`
    FOREIGN KEY (`telefone_id`)
    REFERENCES `db_apae_estoque`.`telefone` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`valores_nutricionais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`valores_nutricionais` (
  `insumos_id` INT NOT NULL,
  `porcao` VARCHAR(50) NULL DEFAULT NULL,
  `calorias` DECIMAL(10,2) NULL DEFAULT NULL,
  `carboidratros` DECIMAL(10,2) NULL DEFAULT NULL,
  `proteinas` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_totais` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_saturadas` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_trans` DECIMAL(10,2) NULL DEFAULT NULL,
  `fibras` DECIMAL(10,2) NULL DEFAULT NULL,
  `acucares` DECIMAL(10,2) NULL DEFAULT NULL,
  `sodio` DECIMAL(10,2) NULL DEFAULT NULL,
  `colesterol` DECIMAL(10,2) NULL DEFAULT NULL,
  `calcio` DECIMAL(10,2) NULL DEFAULT NULL,
  `ferro` DECIMAL(10,2) NULL DEFAULT NULL,
  `potassio` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_a` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_c` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_d` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_e` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_k` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b1` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b2` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b3` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b6` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b12` DECIMAL(10,2) NULL DEFAULT NULL,
  `acido_folico` DECIMAL(10,2) NULL DEFAULT NULL,
  `percentual_valor_diario` JSON NULL DEFAULT NULL,
  PRIMARY KEY (`insumos_id`),
  CONSTRAINT `fk_valores_nutricionais_insumos1`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`estoque_saida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`estoque_saida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `insumos_id` INT NOT NULL,
  `quantidade` DECIMAL(10,2) NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_saida` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `observacao` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_saida_insumos1_idx` (`insumos_id` ASC) VISIBLE,
  INDEX `fk_estoque_saida_unidades_medida1_idx` (`unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_saida_insumos1`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_saida_unidades_medida1`
    FOREIGN KEY (`unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`unidades_medida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`estoque_vencido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`estoque_vencido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `insumos_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_validade` DATE NOT NULL,
  `descartado` TINYINT(1) NOT NULL DEFAULT 0,
  `data_movido` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizado` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_insumos1_idx` (`insumos_id` ASC) VISIBLE,
  INDEX `fk_estoque_unidades_medida1_idx` (`unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_insumos10`
    FOREIGN KEY (`insumos_id`)
    REFERENCES `db_apae_estoque`.`insumos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_unidades_medida10`
    FOREIGN KEY (`unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`unidades_medida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`doacoes_has_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`doacoes_has_pedidos` (
  `doacoes_id` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  PRIMARY KEY (`doacoes_id`, `pedidos_id`),
  INDEX `fk_doacoes_has_pedidos_pedidos1_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_doacoes_has_pedidos_doacoes1_idx` (`doacoes_id` ASC) VISIBLE,
  CONSTRAINT `fk_doacoes_has_pedidos_doacoes1`
    FOREIGN KEY (`doacoes_id`)
    REFERENCES `db_apae_estoque`.`doacoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doacoes_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `db_apae_estoque`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_endereco_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_endereco_main` (
  `endereco_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`endereco_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_endereco_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_endereco_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_endereco_main_endereco_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `tipo` VARCHAR(20) NULL,
  `logradouro` VARCHAR(60) NULL,
  `numero` VARCHAR(10) NULL,
  `complemento` VARCHAR(30) NULL,
  `bairro` VARCHAR(60) NULL,
  `cidade` VARCHAR(60) NULL,
  `estado` CHAR(2) NULL,
  `cep` CHAR(8) NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_endereco_content_log_endereco_main1_idx` (`log_endereco_main_endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_endereco_content_log_endereco_main1`
    FOREIGN KEY (`log_endereco_main_endereco_id`)
    REFERENCES `db_apae_estoque`.`log_endereco_main` (`endereco_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_telefone_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_telefone_main` (
  `telefone_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`telefone_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_telefone_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_telefone_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_telefone_main_telefone_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `tipo` ENUM("fixo", "celular") NULL,
  `ddi` VARCHAR(5) NULL,
  `ddd` CHAR(3) NULL,
  `numero` VARCHAR(10) NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_telefone_content_log_telefone_main1_idx` (`log_telefone_main_telefone_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_telefone_content_log_telefone_main1`
    FOREIGN KEY (`log_telefone_main_telefone_id`)
    REFERENCES `db_apae_estoque`.`log_telefone_main` (`telefone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_pessoas_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_pessoas_main` (
  `pessoas_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pessoas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_pessoas_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_pessoas_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_pessoas_main_pessoas_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `tipo_pessoa` TINYINT(1) NOT NULL,
  `nome` VARCHAR(150) NOT NULL,
  `documento` CHAR(14) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco_id` INT NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC) VISIBLE,
  INDEX `fk_log_pessoas_content_log_pessoas_main1_idx` (`log_pessoas_main_pessoas_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_pessoas_content_log_pessoas_main1`
    FOREIGN KEY (`log_pessoas_main_pessoas_id`)
    REFERENCES `db_apae_estoque`.`log_pessoas_main` (`pessoas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_pessoa_has_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_pessoa_has_telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `telefone_id` INT NOT NULL,
  `acao` ENUM("INSERT", "DELETE") NOT NULL COMMENT 'INSERT = Adicionado\nDELETE = Removido',
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_doacoes_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_doacoes_main` (
  `doacoes_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doacoes_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_doacoes_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_doacoes_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_doacoes_main_doacoes_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `pessoas_id` INT NOT NULL,
  `descricao` TEXT NULL,
  `data_doacao` DATE NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_doacoes_content_log_doacoes_main1_idx` (`log_doacoes_main_doacoes_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_doacoes_content_log_doacoes_main1`
    FOREIGN KEY (`log_doacoes_main_doacoes_id`)
    REFERENCES `db_apae_estoque`.`log_doacoes_main` (`doacoes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_usuarios_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_usuarios_main` (
  `usuarios_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL DEFAULT -1,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuarios_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_usuarios_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_usuarios_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_usuarios_main_usuarios_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `username` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `funcao` ENUM("administrador", "nutricionista", "cozinheiro", "professor", "monitor") NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_usuarios_content_log_usuarios_main1_idx` (`log_usuarios_main_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_usuarios_content_log_usuarios_main1`
    FOREIGN KEY (`log_usuarios_main_usuarios_id`)
    REFERENCES `db_apae_estoque`.`log_usuarios_main` (`usuarios_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_pedidos_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_pedidos_main` (
  `pedidos_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pedidos_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_pedidos_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_pedidos_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_pedidos_main_pedidos_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `usuarios_id` INT NOT NULL,
  `pessoas_id` INT NOT NULL,
  `descricao` TEXT NULL,
  `data_pedido` TIMESTAMP NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_pedidos_content_log_pedidos_main1_idx` (`log_pedidos_main_pedidos_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_pedidos_content_log_pedidos_main1`
    FOREIGN KEY (`log_pedidos_main_pedidos_id`)
    REFERENCES `db_apae_estoque`.`log_pedidos_main` (`pedidos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_doacoes_has_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_doacoes_has_pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doacoes_id` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  `acao` ENUM("INSERT", "UPDATE", "DELETE") NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_itens_pedido_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_itens_pedido_main` (
  `itens_pedido_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`itens_pedido_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_itens_pedido_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_itens_pedido_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_itens_pedido_main_itens_pedido_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `pedidos_id` INT NOT NULL,
  `insumos_id` INT NOT NULL,
  `quantidade` DECIMAL(10,2) NULL,
  `unidades_medida_id` INT NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_itens_pedido_content_log_itens_pedido_main1_idx` (`log_itens_pedido_main_itens_pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_itens_pedido_content_log_itens_pedido_main1`
    FOREIGN KEY (`log_itens_pedido_main_itens_pedido_id`)
    REFERENCES `db_apae_estoque`.`log_itens_pedido_main` (`itens_pedido_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_unidades_medida_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_unidades_medida_main` (
  `unidades_medida_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`unidades_medida_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_unidades_medida_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_unidades_medida_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_unidades_medida_main_unidades_medida_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `nome` VARCHAR(50) NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_unidades_medida_content_log_unidades_medida_main1_idx` (`log_unidades_medida_main_unidades_medida_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_unidades_medida_content_log_unidades_medida_main1`
    FOREIGN KEY (`log_unidades_medida_main_unidades_medida_id`)
    REFERENCES `db_apae_estoque`.`log_unidades_medida_main` (`unidades_medida_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_entrada_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_entrada_main` (
  `estoque_entrada_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`estoque_entrada_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_entrada_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_entrada_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_estoque_entrada_main_estoque_entrada_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `insumos_id` INT NOT NULL,
  `doacoes_id` INT NULL DEFAULT NULL,
  `quantidade` DECIMAL(10,2) NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_validade` DATE NULL,
  `data_entrada` TIMESTAMP NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_entrada_copy1_log_estoque_entrada_main1_idx` (`log_estoque_entrada_main_estoque_entrada_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_entrada_copy1_log_estoque_entrada_main1`
    FOREIGN KEY (`log_estoque_entrada_main_estoque_entrada_id`)
    REFERENCES `db_apae_estoque`.`log_estoque_entrada_main` (`estoque_entrada_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_main` (
  `estoque_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`estoque_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_estoque_main_estoque_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `insumos_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `status_insumo` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Fechado = 0\nAberto = 1\nConsumido = 2\nVence hoje = 3\nVencido = 4',
  `data_validade` DATE NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_copy1_log_estoque_main1_idx` (`log_estoque_main_estoque_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_copy1_log_estoque_main1`
    FOREIGN KEY (`log_estoque_main_estoque_id`)
    REFERENCES `db_apae_estoque`.`log_estoque_main` (`estoque_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_saida_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_saida_main` (
  `estoque_saida_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`estoque_saida_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_saida_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_saida_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_estoque_saida_main_estoque_saida_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `insumos_id` INT NOT NULL,
  `quantidade` DECIMAL(10,2) NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_saida` TIMESTAMP NULL,
  `observacao` TEXT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_saida_copy1_log_estoque_saida_main1_idx` (`log_estoque_saida_main_estoque_saida_id` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_saida_copy1_log_estoque_saida_main1`
    FOREIGN KEY (`log_estoque_saida_main_estoque_saida_id`)
    REFERENCES `db_apae_estoque`.`log_estoque_saida_main` (`estoque_saida_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_vencido_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_vencido_main` (
  `estoque_vencido_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`estoque_vencido_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_estoque_vencido_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_estoque_vencido_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_estoque_vencido_main_estoque_vencido_id` INT NOT NULL,
  `revisao` INT NULL,
  `status` TINYINT(1) NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `insumos_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `unidades_medida_id` INT NOT NULL,
  `data_validade` DATE NOT NULL,
  `descartado` TINYINT(1) NOT NULL DEFAULT 0,
  `data_movido` TIMESTAMP NOT NULL,
  `data_atualizado` TIMESTAMP NULL,
  `modificado_por` INT NULL,
  `data_modificacao` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_estoque_vencido_content_log_estoque_vencido_main1_idx` (`log_estoque_vencido_main_estoque_vencido_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_estoque_vencido_content_log_estoque_vencido_main1`
    FOREIGN KEY (`log_estoque_vencido_main_estoque_vencido_id`)
    REFERENCES `db_apae_estoque`.`log_estoque_vencido_main` (`estoque_vencido_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_insumos_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_insumos_main` (
  `insumos_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`insumos_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_insumos_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_insumos_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_insumos_main_insumos_id` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `nome` VARCHAR(45) NULL,
  `categoria_insumos_id` INT NOT NULL,
  `observacoes` TEXT NULL,
  `revisao` INT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_insumos_content_log_insumos_main1_idx` (`log_insumos_main_insumos_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_insumos_content_log_insumos_main1`
    FOREIGN KEY (`log_insumos_main_insumos_id`)
    REFERENCES `db_apae_estoque`.`log_insumos_main` (`insumos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_categoria_insumos_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_categoria_insumos_main` (
  `categoria_insumos_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`categoria_insumos_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_categoria_insumos_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_categoria_insumos_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_categoria_insumos_main_categoria_insumos_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `nome` VARCHAR(100) NOT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_categoria_insumos_content_log_categoria_insumos_main_idx` (`log_categoria_insumos_main_categoria_insumos_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_categoria_insumos_content_log_categoria_insumos_main1`
    FOREIGN KEY (`log_categoria_insumos_main_categoria_insumos_id`)
    REFERENCES `db_apae_estoque`.`log_categoria_insumos_main` (`categoria_insumos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_valores_nutricionais_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_valores_nutricionais_main` (
  `valores_nutricionais_insumos_id` INT NOT NULL,
  `revisao_atual` INT NOT NULL DEFAULT 1,
  `criado_por` INT NOT NULL,
  `data_criado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`valores_nutricionais_insumos_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_apae_estoque`.`log_valores_nutricionais_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`log_valores_nutricionais_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `log_valores_nutricionais_main_valores_nutricionais_insumos_id` INT NOT NULL,
  `revisao` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '0 = Deletado\n1 = Ativo',
  `porcao` VARCHAR(50) NULL DEFAULT NULL,
  `calorias` DECIMAL(10,2) NULL DEFAULT NULL,
  `carboidratros` DECIMAL(10,2) NULL DEFAULT NULL,
  `proteinas` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_totais` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_saturadas` DECIMAL(10,2) NULL DEFAULT NULL,
  `gorduras_trans` DECIMAL(10,2) NULL DEFAULT NULL,
  `fibras` DECIMAL(10,2) NULL DEFAULT NULL,
  `acucares` DECIMAL(10,2) NULL DEFAULT NULL,
  `sodio` DECIMAL(10,2) NULL DEFAULT NULL,
  `colesterol` DECIMAL(10,2) NULL DEFAULT NULL,
  `calcio` DECIMAL(10,2) NULL DEFAULT NULL,
  `ferro` DECIMAL(10,2) NULL DEFAULT NULL,
  `potassio` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_a` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_c` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_d` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_e` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_k` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b1` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b2` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b3` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b6` DECIMAL(10,2) NULL DEFAULT NULL,
  `vitamina_b12` DECIMAL(10,2) NULL DEFAULT NULL,
  `acido_folico` DECIMAL(10,2) NULL DEFAULT NULL,
  `percentual_valor_diario` JSON NULL DEFAULT NULL,
  `modificado_por` INT NOT NULL,
  `data_modificacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_valores_nutricionais_copy1_log_valores_nutricionais_main_idx` (`log_valores_nutricionais_main_valores_nutricionais_insumos_id` ASC) VISIBLE,
  CONSTRAINT `fk_valores_nutricionais_copy1_log_valores_nutricionais_main1`
    FOREIGN KEY (`log_valores_nutricionais_main_valores_nutricionais_insumos_id`)
    REFERENCES `db_apae_estoque`.`log_valores_nutricionais_main` (`valores_nutricionais_insumos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db_apae_estoque` ;

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view_estoque_fechado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view_estoque_fechado` (`nome_insumo` INT, `quantidade_total` INT, `unidade_medida` INT, `data_validade` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view_estoque_aberto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view_estoque_aberto` (`nome_insumo` INT, `quantidade_total` INT, `unidade_medida` INT, `data_validade` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view_estoque_vencendo_hoje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view_estoque_vencendo_hoje` (`nome_insumo` INT, `quantidade_total` INT, `unidade_medida` INT, `data_validade` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view_insumos_vencidos_descartados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view_insumos_vencidos_descartados` (`nome_insumo` INT, `quantidade_total` INT, `unidade_medida` INT, `data_validade` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view_pessoas_doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view_pessoas_doacoes` (`nome_pessoa` INT, `tipo_pessoa` INT, `numero_doacoes` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_apae_estoque`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_apae_estoque`.`view1` (`id` INT);

-- -----------------------------------------------------
-- procedure proc_inserir_estoque_entrada
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_inserir_estoque_entrada` (
    IN `p_insumos_id` INT,
    IN `p_quantidade` DECIMAL(10,2),
    IN `p_unidades_medida_id` INT,
    IN `p_data_validade` DATE,
    IN `p_doacoes_id` INT
)
BEGIN
    INSERT INTO `estoque_entrada` (`insumos_id`, `quantidade`, `unidades_medida_id`, `data_validade`, `doacoes_id`)
    VALUES (p_insumos_id, p_quantidade, p_unidades_medida_id, p_data_validade, p_doacoes_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_inserir_estoque
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_inserir_estoque` (
    IN `p_insumos_id` INT,
    IN `p_quantidade` DECIMAL(10,2),
    IN `p_unidades_medida_id` INT,
    IN `p_status` TINYINT(1),
    IN `p_data_validade` DATE
)
BEGIN
    INSERT INTO `estoque` (`insumos_id`, `quantidade`, `unidades_medida_id`, `status`, `data_validade`)
    VALUES (p_insumos_id, p_quantidade, p_unidades_medida_id, p_status, p_data_validade);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_inserir_estoque_saida
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_inserir_estoque_saida` (
    IN `p_insumos_id` INT,
    IN `p_quantidade` DECIMAL(10,2),
    IN `p_unidades_medida_id` INT,
    IN `p_observacao` TEXT
)
BEGIN
    INSERT INTO `estoque_saida` (`insumos_id`, `quantidade`, `unidades_medida_id`, `data_saida`, `observacao`)
    VALUES (p_insumos_id, p_quantidade, p_unidades_medida_id, NOW(), p_observacao);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_inserir_estoque_vencido
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_inserir_estoque_vencido` (
    IN `p_insumos_id` INT,
    IN `p_quantidade` DECIMAL(10,2),
    IN `p_unidades_medida_id` INT,
    IN `p_data_validade` DATE
)
BEGIN
    INSERT INTO `estoque_vencido` (`insumos_id`, `quantidade`, `unidades_medida_id`, `data_validade`, `descartado`)
    VALUES (p_insumos_id, p_quantidade, p_unidades_medida_id, p_data_validade, 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_get_doacoes_por_pessoa
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_get_doacoes_por_pessoa` (IN p_pessoa_id INT)
BEGIN
    SELECT 
        d.id AS `id_doacao`,
        d.descricao AS `descricao`,
        d.data_doacao AS `data_doacao`
    FROM 
        `doacoes` d
    WHERE 
        d.pessoas_id = p_pessoa_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_get_estoque_entrada_por_doacao
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE `proc_get_estoque_entrada_por_doacao` (
    IN p_doacao_id INT
)
BEGIN
    SELECT 
        ee.id AS `id_estoque_entrada`,
        i.nome AS `nome_insumo`,
        ee.quantidade AS `quantidade`,
        um.nome AS `unidade_medida`,
        ee.data_validade AS `data_validade`,
        ee.data_entrada AS `data_entrada`
    FROM 
        `estoque_entrada` ee
    JOIN 
        `insumos` i ON ee.insumos_id = i.id
    JOIN 
        `unidades_medida` um ON ee.unidades_medida_id = um.id
    WHERE 
        ee.doacoes_id = p_doacao_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function func_validar_cnpj
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE FUNCTION func_validar_cnpj(CNPJ CHAR(14)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE INDICE INT;
    DECLARE SOMA INT;
    DECLARE DIGITO_1 INT;
    DECLARE DIGITO_2 INT;
    DECLARE VAR1 INT;
    DECLARE VAR2 INT;
    DECLARE DIGITO_1_CNPJ CHAR(1);
    DECLARE DIGITO_2_CNPJ CHAR(1);
    DECLARE NR_DOCUMENTO_AUX VARCHAR(14);
    
    SET SOMA = 0;
    SET INDICE = 1;
    SET VAR1 = 5;
    SET NR_DOCUMENTO_AUX = LTRIM(RTRIM(CNPJ));
    
    IF (NR_DOCUMENTO_AUX IN ('00000000000000', '11111111111111', '22222222222222', '33333333333333', '44444444444444', '55555555555555', '66666666666666', '77777777777777', '88888888888888', '99999999999999')) THEN
        RETURN 0;
    END IF;
    IF (LENGTH(NR_DOCUMENTO_AUX) <> 14) THEN
        RETURN 0;
    END IF;
    
    SET DIGITO_1_CNPJ = SUBSTRING(CNPJ, LENGTH(CNPJ) - 1, 1);
    SET DIGITO_2_CNPJ = SUBSTRING(CNPJ, LENGTH(CNPJ), 1);
    
    WHILE (INDICE <= 4 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR1;
        SET INDICE = INDICE + 1;
        SET VAR1 = VAR1 - 1;
    END WHILE;
    
    SET VAR2 = 9;
    WHILE (INDICE <= 12 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR2;
        SET INDICE = INDICE + 1;
        SET VAR2 = VAR2 - 1;
    END WHILE;
    
    SET DIGITO_1 = (SOMA % 11 );
    
    IF DIGITO_1 < 2 THEN
        SET DIGITO_1 = 0;
    ELSE
        SET DIGITO_1 = 11 - (SOMA % 11);
    END IF;
    
    SET INDICE = 1;
    SET SOMA = 0;
    SET VAR1 = 6;
    
    WHILE (INDICE <= 5 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR1;
        SET INDICE = INDICE + 1;
        SET VAR1 = VAR1 - 1;
    END WHILE;
    
    SET VAR2 = 9;
    WHILE (INDICE <= 13 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR2;
        SET INDICE = INDICE + 1;
        SET VAR2 = VAR2 - 1;
    END WHILE;
    
    SET DIGITO_2 = (SOMA % 11);
    
    IF DIGITO_2 < 2 THEN
        SET DIGITO_2 = 0;
    ELSE
        SET DIGITO_2 = 11 - (SOMA % 11);
    END IF;
    
    IF (DIGITO_1 = DIGITO_1_CNPJ) AND (DIGITO_2 = DIGITO_2_CNPJ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function func_validar_cpf
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE FUNCTION func_validar_cpf(CPF CHAR(11)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE SOMA INT;
    DECLARE INDICE INT;
    DECLARE DIGITO_1 INT;
    DECLARE DIGITO_2 INT;
    DECLARE NR_DOCUMENTO_AUX VARCHAR(11);
    DECLARE DIGITO_1_CPF CHAR(1);
    DECLARE DIGITO_2_CPF CHAR(1);

    -- Remove os CPFs onde todos os números são iguais
    SET NR_DOCUMENTO_AUX = LTRIM(RTRIM(CPF));
    IF (NR_DOCUMENTO_AUX IN ('00000000000', '11111111111', '22222222222', '33333333333', 
                             '44444444444', '55555555555', '66666666666', '77777777777', 
                             '88888888888', '99999999999', '12345678909')) THEN
        RETURN 0;
    END IF;

    -- O CPF deve ter 11 caracteres
    IF (LENGTH(NR_DOCUMENTO_AUX) <> 11) THEN
        RETURN 0;
    ELSE
        -- Armazenando os dígitos verificadores do CPF informado
        SET DIGITO_1_CPF = SUBSTRING(NR_DOCUMENTO_AUX, 10, 1);
        SET DIGITO_2_CPF = SUBSTRING(NR_DOCUMENTO_AUX, 11, 1);

        -- Cálculo do primeiro dígito verificador
        SET SOMA = 0;
        SET INDICE = 1;
        WHILE (INDICE <= 9) DO
            SET SOMA = SOMA + CAST(SUBSTRING(NR_DOCUMENTO_AUX, INDICE, 1) AS UNSIGNED) * (11 - INDICE);
            SET INDICE = INDICE + 1;
        END WHILE;
        SET DIGITO_1 = 11 - (SOMA % 11);
        IF (DIGITO_1 > 9) THEN
            SET DIGITO_1 = 0;
        END IF;

        -- Cálculo do segundo dígito verificador
        SET SOMA = 0;
        SET INDICE = 1;
        WHILE (INDICE <= 10) DO
            SET SOMA = SOMA + CAST(SUBSTRING(NR_DOCUMENTO_AUX, INDICE, 1) AS UNSIGNED) * (12 - INDICE);
            SET INDICE = INDICE + 1;
        END WHILE;
        SET DIGITO_2 = 11 - (SOMA % 11);
        IF DIGITO_2 > 9 THEN
            SET DIGITO_2 = 0;
        END IF;

        -- Validando os dígitos verificadores calculados com os dígitos verificadores do CPF informado
        IF (DIGITO_1 = DIGITO_1_CPF) AND (DIGITO_2 = DIGITO_2_CPF) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_validar_documento
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE proc_validar_documento (
    IN p_tipo_pessoa TINYINT(1),
    IN p_documento CHAR(14)
)
BEGIN
    DECLARE v_resultado INT;

    IF p_tipo_pessoa = 0 THEN
        -- Validação de CPF
        SET v_resultado = func_validar_cpf(p_documento);
        IF v_resultado = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CPF inválido.';
        END IF;
    ELSEIF p_tipo_pessoa = 1 THEN
        -- Validação de CNPJ
        SET v_resultado = func_validar_cnpj(p_documento);
        IF v_resultado = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CNPJ inválido.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de pessoa inválido.';
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_atualizar_e_mover_estoque
-- -----------------------------------------------------

DELIMITER $$
USE `db_apae_estoque`$$
CREATE PROCEDURE proc_atualizar_e_mover_estoque(
    IN estoque_id INT,
    IN novo_status TINYINT(1),
    IN observacao TEXT
)
BEGIN
    DECLARE v_quantidade DECIMAL(10,2);
    DECLARE v_insumos_id INT;
    DECLARE v_unidades_medida_id INT;
    DECLARE v_data_validade DATE;

    -- Obter a quantidade e outras informações necessárias antes da atualização
    SELECT quantidade, insumos_id, unidades_medida_id, data_validade
    INTO v_quantidade, v_insumos_id, v_unidades_medida_id, v_data_validade
    FROM `db_apae_estoque`.`estoque`
    WHERE id = estoque_id;

    -- Atualizar o status no estoque
    UPDATE `db_apae_estoque`.`estoque`
    SET `status` = novo_status
    WHERE `id` = estoque_id;

    -- Verificar o novo status e mover para a tabela apropriada
    IF novo_status = 2 THEN
        CALL proc_inserir_estoque_saida(
            v_insumos_id,
            v_quantidade,
            v_unidades_medida_id,
            observacao
        );
        DELETE FROM `db_apae_estoque`.`estoque` WHERE `id` = estoque_id;
    ELSEIF novo_status = 4 THEN
        CALL proc_inserir_estoque_vencido(
            v_insumos_id,
            v_quantidade,
            v_unidades_medida_id,
            v_data_validade
        );
        DELETE FROM `db_apae_estoque`.`estoque` WHERE `id` = estoque_id;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view_estoque_fechado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view_estoque_fechado`;
USE `db_apae_estoque`;
CREATE OR REPLACE VIEW `view_estoque_fechado` AS
SELECT 
    i.nome AS `nome_insumo`,
    SUM(e.quantidade) AS `quantidade_total`,
    um.nome AS `unidade_medida`,
    e.data_validade
FROM 
    `estoque` e
JOIN 
    `insumos` i ON e.insumos_id = i.id
JOIN 
    `unidades_medida` um ON e.unidades_medida_id = um.id
WHERE 
    e.status = 0
GROUP BY 
    i.nome, um.nome, e.data_validade;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view_estoque_aberto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view_estoque_aberto`;
USE `db_apae_estoque`;
CREATE OR REPLACE VIEW `view_estoque_aberto` AS
SELECT 
    i.nome AS `nome_insumo`,
    SUM(e.quantidade) AS `quantidade_total`,
    um.nome AS `unidade_medida`,
    e.data_validade
FROM 
    `estoque` e
JOIN 
    `insumos` i ON e.insumos_id = i.id
JOIN 
    `unidades_medida` um ON e.unidades_medida_id = um.id
WHERE 
    e.status = 1
GROUP BY 
    i.nome, um.nome, e.data_validade;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view_estoque_vencendo_hoje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view_estoque_vencendo_hoje`;
USE `db_apae_estoque`;
CREATE OR REPLACE VIEW `view_estoque_vencendo_hoje` AS
SELECT 
    i.nome AS `nome_insumo`,
    SUM(e.quantidade) AS `quantidade_total`,
    um.nome AS `unidade_medida`,
    e.data_validade
FROM 
    `estoque` e
JOIN 
    `insumos` i ON e.insumos_id = i.id
JOIN 
    `unidades_medida` um ON e.unidades_medida_id = um.id
WHERE 
    e.status = 3
GROUP BY 
    i.nome, um.nome, e.data_validade;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view_insumos_vencidos_descartados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view_insumos_vencidos_descartados`;
USE `db_apae_estoque`;
CREATE OR REPLACE VIEW `view_insumos_vencidos_descartados` AS
SELECT 
    i.nome AS `nome_insumo`,
    SUM(v.quantidade) AS `quantidade_total`,
    um.nome AS `unidade_medida`,
    v.data_validade
FROM 
    `estoque_vencido` v
JOIN 
    `insumos` i ON v.insumos_id = i.id
JOIN 
    `unidades_medida` um ON v.unidades_medida_id = um.id
WHERE 
    v.descartado = 0
GROUP BY 
    i.nome, um.nome, v.data_validade;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view_pessoas_doacoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view_pessoas_doacoes`;
USE `db_apae_estoque`;
CREATE OR REPLACE VIEW `view_pessoas_doacoes` AS
SELECT 
    p.nome AS `nome_pessoa`,
    CASE 
        WHEN p.tipo_pessoa = 0 THEN 'pessoa física'
        WHEN p.tipo_pessoa = 1 THEN 'pessoa jurídica'
    END AS `tipo_pessoa`,
    COUNT(d.id) AS `numero_doacoes`
FROM 
    `pessoas` p
LEFT JOIN 
    `doacoes` d ON p.id = d.pessoas_id
GROUP BY 
    p.nome, p.tipo_pessoa;

-- -----------------------------------------------------
-- View `db_apae_estoque`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_apae_estoque`.`view1`;
USE `db_apae_estoque`;
USE `db_apae_estoque`;

CREATE OR REPLACE VIEW `view_estoque_saida` AS
SELECT 
    i.nome AS `nome_insumo`,
    SUM(es.quantidade) AS `quantidade_total`,
    um.nome AS `unidade_medida`,
    es.data_saida,
    es.observacao
FROM 
    `estoque_saida` es
JOIN 
    `insumos` i ON es.insumos_id = i.id
JOIN 
    `unidades_medida` um ON es.unidades_medida_id = um.id
GROUP BY 
    i.nome, um.nome, es.data_saida, es.observacao;
USE `db_apae_estoque`;

DELIMITER $$
USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_usuarios` AFTER INSERT ON `usuarios` FOR EACH ROW
BEGIN
    -- Inserir na tabela principal de log
    INSERT INTO `log_usuarios_main` (
        `usuarios_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        NEW.id, -- Usar o próprio ID do usuário recém-criado
        NOW()
    );
    
    -- Inserir na tabela de conteúdo de log
    INSERT INTO `log_usuarios_content` (
        `log_usuarios_main_usuarios_id`,
        `revisao`,
        `status`,
        `username`,
        `senha`,
        `email`,
        `funcao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.username,
        NEW.senha,
        NEW.email,
        NEW.funcao,
        NEW.id, -- Usar o próprio ID do usuário recém-criado
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_usuarios` AFTER UPDATE ON `usuarios` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_usuarios_main` WHERE `usuarios_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_usuarios_main` SET `revisao_atual` = nova_revisao WHERE `usuarios_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_usuarios_content` (
        `log_usuarios_main_usuarios_id`,
        `revisao`,
        `status`,
        `username`,
        `senha`,
        `email`,
        `funcao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.username,
        NEW.senha,
        NEW.email,
        NEW.funcao,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_usuarios` AFTER DELETE ON `usuarios` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_usuarios_content` (
        `log_usuarios_main_usuarios_id`,
        `revisao`,
        `status`,
        `username`,
        `senha`,
        `email`,
        `funcao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_usuarios_main` WHERE `usuarios_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.username,
        OLD.senha,
        OLD.email,
        OLD.funcao,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_endereco` AFTER INSERT ON `endereco` FOR EACH ROW
BEGIN
    INSERT INTO `log_endereco_main` (
        `endereco_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id,
        NOW()
    );
    
    INSERT INTO `log_endereco_content` (
        `log_endereco_main_endereco_id`,
        `revisao`,
        `status`,
        `tipo`,
        `logradouro`,
        `numero`,
        `complemento`,
        `bairro`,
        `cidade`,
        `estado`,
        `cep`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.tipo,
        NEW.logradouro,
        NEW.numero,
        NEW.complemento,
        NEW.bairro,
        NEW.cidade,
        NEW.estado,
        NEW.cep,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_endereco` AFTER UPDATE ON `endereco` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_endereco_main` WHERE `endereco_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_endereco_main` SET `revisao_atual` = nova_revisao WHERE `endereco_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_endereco_content` (
        `log_endereco_main_endereco_id`,
        `revisao`,
        `status`,
        `tipo`,
        `logradouro`,
        `numero`,
        `complemento`,
        `bairro`,
        `cidade`,
        `estado`,
        `cep`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.tipo,
        NEW.logradouro,
        NEW.numero,
        NEW.complemento,
        NEW.bairro,
        NEW.cidade,
        NEW.estado,
        NEW.cep,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_endereco` AFTER DELETE ON `endereco` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_endereco_content` (
        `log_endereco_main_endereco_id`,
        `revisao`,
        `status`,
        `tipo`,
        `logradouro`,
        `numero`,
        `complemento`,
        `bairro`,
        `cidade`,
        `estado`,
        `cep`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_endereco_main` WHERE `endereco_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.tipo,
        OLD.logradouro,
        OLD.numero,
        OLD.complemento,
        OLD.bairro,
        OLD.cidade,
        OLD.estado,
        OLD.cep,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_bf_validar_documento` BEFORE INSERT ON `pessoas` FOR EACH ROW
BEGIN
    CALL proc_validar_documento(NEW.tipo_pessoa, NEW.documento);
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_pessoas` AFTER INSERT ON `pessoas` FOR EACH ROW
BEGIN
    -- Inserir na tabela principal de log
    INSERT INTO `log_pessoas_main` (
        `pessoas_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
    
    -- Inserir na tabela de conteúdo de log
    INSERT INTO `log_pessoas_content` (
        `log_pessoas_main_pessoas_id`,
        `revisao`,
        `status`,
        `tipo_pessoa`,
        `nome`,
        `documento`,
        `data_nascimento`,
        `email`,
        `endereco_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.tipo_pessoa,
        NEW.nome,
        NEW.documento,
        NEW.data_nascimento,
        NEW.email,
        NEW.endereco_id,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_pessoas` AFTER UPDATE ON `pessoas` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_pessoas_main` WHERE `pessoas_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_pessoas_main` SET `revisao_atual` = nova_revisao WHERE `pessoas_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_pessoas_content` (
        `log_pessoas_main_pessoas_id`,
        `revisao`,
        `status`,
        `tipo_pessoa`,
        `nome`,
        `documento`,
        `data_nascimento`,
        `email`,
        `endereco_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.tipo_pessoa,
        NEW.nome,
        NEW.documento,
        NEW.data_nascimento,
        NEW.email,
        NEW.endereco_id,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_pessoas` AFTER DELETE ON `pessoas` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_pessoas_content` (
        `log_pessoas_main_pessoas_id`,
        `revisao`,
        `status`,
        `tipo_pessoa`,
        `nome`,
        `documento`,
        `data_nascimento`,
        `email`,
        `endereco_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_pessoas_main` WHERE `pessoas_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.tipo_pessoa,
        OLD.nome,
        OLD.documento,
        OLD.data_nascimento,
        OLD.email,
        OLD.endereco_id,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_telefone` AFTER INSERT ON `telefone` FOR EACH ROW
BEGIN
    -- Inserir na tabela principal de log
    INSERT INTO `log_telefone_main` (
        `telefone_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
    
    -- Inserir na tabela de conteúdo de log
    INSERT INTO `log_telefone_content` (
        `log_telefone_main_telefone_id`,
        `revisao`,
        `status`,
        `tipo`,
        `ddi`,
        `ddd`,
        `numero`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.tipo,
        NEW.ddi,
        NEW.ddd,
        NEW.numero,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_telefone` AFTER UPDATE ON `telefone` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_telefone_main` WHERE `telefone_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_telefone_main` SET `revisao_atual` = nova_revisao WHERE `telefone_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_telefone_content` (
        `log_telefone_main_telefone_id`,
        `revisao`,
        `status`,
        `tipo`,
        `ddi`,
        `ddd`,
        `numero`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.tipo,
        NEW.ddi,
        NEW.ddd,
        NEW.numero,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_telefone` AFTER DELETE ON `telefone` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_telefone_content` (
        `log_telefone_main_telefone_id`,
        `revisao`,
        `status`,
        `tipo`,
        `ddi`,
        `ddd`,
        `numero`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_telefone_main` WHERE `telefone_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.tipo,
        OLD.ddi,
        OLD.ddd,
        OLD.numero,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_categoria_insumos` AFTER INSERT ON `categoria_insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT DEFAULT 1;

    -- Inserir na tabela main
    INSERT INTO `db_apae_estoque`.`log_categoria_insumos_main` (`categoria_insumos_id`, `revisao_atual`, `criado_por`)
    VALUES (NEW.id, nova_revisao, @user_id);

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_categoria_insumos_content` (
        `log_categoria_insumos_main_categoria_insumos_id`,
        `revisao`,
        `nome`,
        `status`,
        `modificado_por`
    ) VALUES (
        NEW.id,
        nova_revisao,
        NEW.nome,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_categoria_insumos` AFTER UPDATE ON `categoria_insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_categoria_insumos_main`
                        WHERE `categoria_insumos_id` = OLD.id);

    UPDATE `db_apae_estoque`.`log_categoria_insumos_main`
    SET `revisao_atual` = nova_revisao
    WHERE `categoria_insumos_id` = OLD.id;

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_categoria_insumos_content` (
        `log_categoria_insumos_main_categoria_insumos_id`,
        `revisao`,
        `nome`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        NEW.nome,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_categoria_insumos` AFTER DELETE ON `categoria_insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_categoria_insumos_main`
                        WHERE `categoria_insumos_id` = OLD.id);

    UPDATE `db_apae_estoque`.`log_categoria_insumos_main`
    SET `revisao_atual` = nova_revisao
    WHERE `categoria_insumos_id` = OLD.id;

    -- Inserir na tabela content com status de deletado
    INSERT INTO `db_apae_estoque`.`log_categoria_insumos_content` (
        `log_categoria_insumos_main_categoria_insumos_id`,
        `revisao`,
        `nome`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        OLD.nome,
        0,  -- Status "Deletado"
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_ai_novo_valor_nutricional` AFTER INSERT ON `insumos` FOR EACH ROW
BEGIN
	INSERT INTO `db_apae_estoque`.`valores_nutricionais` (`insumos_id`)
    VALUES (NEW.id);
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_insumos` AFTER INSERT ON `insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT DEFAULT 1;
    
    -- Inserir na tabela main
    INSERT INTO `db_apae_estoque`.`log_insumos_main` (`insumos_id`, `revisao_atual`, `criado_por`)
    VALUES (NEW.id, nova_revisao, @user_id);

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_insumos_content` (
        `log_insumos_main_insumos_id`,
        `revisao`,
        `nome`,
        `categoria_insumos_id`,
        `observacoes`,
        `status`,
        `modificado_por`
    ) VALUES (
        NEW.id,
        nova_revisao,
        NEW.nome,
        NEW.categoria_insumos_id,
        NEW.observacoes,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_insumos` AFTER UPDATE ON `insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_insumos_main`
                        WHERE `insumos_id` = OLD.id);
    
    UPDATE `db_apae_estoque`.`log_insumos_main`
    SET `revisao_atual` = nova_revisao
    WHERE `insumos_id` = OLD.id;
    
    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_insumos_content` (
        `log_insumos_main_insumos_id`,
        `revisao`,
        `nome`,
        `categoria_insumos_id`,
        `observacoes`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        NEW.nome,
        NEW.categoria_insumos_id,
        NEW.observacoes,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_insumos` AFTER DELETE ON `insumos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_insumos_main`
                        WHERE `insumos_id` = OLD.id);

    UPDATE `db_apae_estoque`.`log_insumos_main`
    SET `revisao_atual` = nova_revisao
    WHERE `insumos_id` = OLD.id;

    -- Inserir na tabela content com status de deletado
    INSERT INTO `db_apae_estoque`.`log_insumos_content` (
        `log_insumos_main_insumos_id`,
        `revisao`,
        `nome`,
        `categoria_insumos_id`,
        `observacoes`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        OLD.nome,
        OLD.categoria_insumos_id,
        OLD.observacoes,
        0,  -- Status "Deletado"
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_doacoes` AFTER INSERT ON `doacoes` FOR EACH ROW
BEGIN
    -- Inserir na tabela principal de log
    INSERT INTO `log_doacoes_main` (
        `doacoes_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
    
    -- Inserir na tabela de conteúdo de log
    INSERT INTO `log_doacoes_content` (
        `log_doacoes_main_doacoes_id`,
        `revisao`,
        `status`,
        `pessoas_id`,
        `descricao`,
        `data_doacao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.pessoas_id,
        NEW.descricao,
        NEW.data_doacao,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_doacoes` AFTER UPDATE ON `doacoes` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_doacoes_main` WHERE `doacoes_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_doacoes_main` SET `revisao_atual` = nova_revisao WHERE `doacoes_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_doacoes_content` (
        `log_doacoes_main_doacoes_id`,
        `revisao`,
        `status`,
        `pessoas_id`,
        `descricao`,
        `data_doacao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.pessoas_id,
        NEW.descricao,
        NEW.data_doacao,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_doacoes` AFTER DELETE ON `doacoes` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_doacoes_content` (
        `log_doacoes_main_doacoes_id`,
        `revisao`,
        `status`,
        `pessoas_id`,
        `descricao`,
        `data_doacao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_doacoes_main` WHERE `doacoes_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.pessoas_id,
        OLD.descricao,
        OLD.data_doacao,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_pedidos` AFTER INSERT ON `pedidos` FOR EACH ROW
BEGIN
    -- Inserir na tabela principal de log
    INSERT INTO `log_pedidos_main` (
        `pedidos_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
    
    -- Inserir na tabela de conteúdo de log
    INSERT INTO `log_pedidos_content` (
        `log_pedidos_main_pedidos_id`,
        `revisao`,
        `status`,
        `usuarios_id`,
        `pessoas_id`,
        `descricao`,
        `data_pedido`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1,
        1, -- Status padrão como ativo
        NEW.usuarios_id,
        NEW.pessoas_id,
        NEW.descricao,
        NEW.data_pedido,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_pedidos` AFTER UPDATE ON `pedidos` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Incrementar o número da revisão
    SET nova_revisao = (SELECT revisao_atual FROM `log_pedidos_main` WHERE `pedidos_id` = OLD.id) + 1;
    
    -- Atualizar a tabela principal de log com a nova revisão
    UPDATE `log_pedidos_main` SET `revisao_atual` = nova_revisao WHERE `pedidos_id` = OLD.id;
    
    -- Criar uma nova versão na tabela de conteúdo de log
    INSERT INTO `log_pedidos_content` (
        `log_pedidos_main_pedidos_id`,
        `revisao`,
        `status`,
        `usuarios_id`,
        `pessoas_id`,
        `descricao`,
        `data_pedido`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        nova_revisao,
        1, -- Status padrão como ativo
        NEW.usuarios_id,
        NEW.pessoas_id,
        NEW.descricao,
        NEW.data_pedido,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_pedidos` AFTER DELETE ON `pedidos` FOR EACH ROW
BEGIN
    -- Criar uma versão final no log indicando que o registro foi excluído
    INSERT INTO `log_pedidos_content` (
        `log_pedidos_main_pedidos_id`,
        `revisao`,
        `status`,
        `usuarios_id`,
        `pessoas_id`,
        `descricao`,
        `data_pedido`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        (SELECT revisao_atual FROM `log_pedidos_main` WHERE `pedidos_id` = OLD.id) + 1,
        0, -- Marcar como deletado
        OLD.usuarios_id,
        OLD.pessoas_id,
        OLD.descricao,
        OLD.data_pedido,
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_unidades_medida` AFTER INSERT ON `unidades_medida` FOR EACH ROW
BEGIN
    -- Insere na tabela log_unidades_medida_main
    INSERT INTO `log_unidades_medida_main` (
        `unidades_medida_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id,
        NOW()
    );

    -- Insere na tabela de conteúdo do log com a primeira revisão
    INSERT INTO `log_unidades_medida_content` (
        `log_unidades_medida_main_unidades_medida_id`,
        `revisao`,
        `status`,
        `nome`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        1, -- Ativo
        NEW.nome,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_unidades_medida` AFTER UPDATE ON `unidades_medida` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_unidades_medida_main
    UPDATE `log_unidades_medida_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `unidades_medida_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_unidades_medida_main`
    WHERE `unidades_medida_id` = OLD.id;

    -- Insere a nova versão na tabela log_unidades_medida_content
    INSERT INTO `log_unidades_medida_content` (
        `log_unidades_medida_main_unidades_medida_id`,
        `revisao`,
        `status`,
        `nome`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        1, -- Ativo
        NEW.nome,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_unidades_medida` AFTER DELETE ON `unidades_medida` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_unidades_medida_main
    UPDATE `log_unidades_medida_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `unidades_medida_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_unidades_medida_main`
    WHERE `unidades_medida_id` = OLD.id;

    -- Insere a nova versão na tabela log_unidades_medida_content com status de deletado
    INSERT INTO `log_unidades_medida_content` (
        `log_unidades_medida_main_unidades_medida_id`,
        `revisao`,
        `status`,
        `nome`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        0, -- Deletado
        OLD.nome,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_itens_pedido` AFTER INSERT ON `itens_pedido` FOR EACH ROW
BEGIN
    -- Insere na tabela log_itens_pedido_main
    INSERT INTO `log_itens_pedido_main` (
        `itens_pedido_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id,
        NOW()
    );

    -- Insere na tabela de conteúdo do log com a primeira revisão
    INSERT INTO `log_itens_pedido_content` (
        `log_itens_pedido_main_itens_pedido_id`,
        `revisao`,
        `status`,
        `pedidos_id`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        1, -- Ativo
        NEW.pedidos_id,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_itens_pedido` AFTER UPDATE ON `itens_pedido` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_itens_pedido_main
    UPDATE `log_itens_pedido_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `itens_pedido_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_itens_pedido_main`
    WHERE `itens_pedido_id` = OLD.id;

    -- Insere a nova versão na tabela log_itens_pedido_content
    INSERT INTO `log_itens_pedido_content` (
        `log_itens_pedido_main_itens_pedido_id`,
        `revisao`,
        `status`,
        `pedidos_id`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        1, -- Ativo
        NEW.pedidos_id,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_itens_pedido` AFTER DELETE ON `itens_pedido` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_itens_pedido_main
    UPDATE `log_itens_pedido_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `itens_pedido_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_itens_pedido_main`
    WHERE `itens_pedido_id` = OLD.id;

    -- Insere a nova versão na tabela log_itens_pedido_content com status de deletado
    INSERT INTO `log_itens_pedido_content` (
        `log_itens_pedido_main_itens_pedido_id`,
        `revisao`,
        `status`,
        `pedidos_id`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        0, -- Deletado
        OLD.pedidos_id,
        OLD.insumos_id,
        OLD.quantidade,
        OLD.unidades_medida_id,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_ai_adicionar_estoque` AFTER INSERT ON `estoque_entrada` FOR EACH ROW
BEGIN
    CALL proc_inserir_estoque(
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        0,  -- Status "Fechado"
        NEW.data_validade
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_estoque_entrada` AFTER INSERT ON `estoque_entrada` FOR EACH ROW
BEGIN
    -- Insere na tabela log_estoque_entrada_main
    INSERT INTO `log_estoque_entrada_main` (
        `estoque_entrada_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id,
        NOW()
    );

    -- Insere na tabela de conteúdo do log com a primeira revisão
    INSERT INTO `log_estoque_entrada_content` (
        `log_estoque_entrada_main_estoque_entrada_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `doacoes_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `data_entrada`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        1, -- Ativo
        NEW.insumos_id,
        NEW.doacoes_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_validade,
        NEW.data_entrada,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_estoque_entrada` AFTER UPDATE ON `estoque_entrada` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_estoque_entrada_main
    UPDATE `log_estoque_entrada_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `estoque_entrada_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_estoque_entrada_main`
    WHERE `estoque_entrada_id` = OLD.id;

    -- Insere a nova versão na tabela log_estoque_entrada_content
    INSERT INTO `log_estoque_entrada_content` (
        `log_estoque_entrada_main_estoque_entrada_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `doacoes_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `data_entrada`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        1, -- Ativo
        NEW.insumos_id,
        NEW.doacoes_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_validade,
        NEW.data_entrada,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_estoque_entrada` AFTER DELETE ON `estoque_entrada` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_estoque_entrada_main
    UPDATE `log_estoque_entrada_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `estoque_entrada_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_estoque_entrada_main`
    WHERE `estoque_entrada_id` = OLD.id;

    -- Insere a nova versão na tabela log_estoque_entrada_content com status de deletado
    INSERT INTO `log_estoque_entrada_content` (
        `log_estoque_entrada_main_estoque_entrada_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `doacoes_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `data_entrada`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        0, -- Deletado
        OLD.insumos_id,
        OLD.doacoes_id,
        OLD.quantidade,
        OLD.unidades_medida_id,
        OLD.data_validade,
        OLD.data_entrada,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_estoque` AFTER INSERT ON `estoque` FOR EACH ROW
BEGIN
    -- Insere na tabela log_estoque_main
    INSERT INTO `log_estoque_main` (
        `estoque_id`,
        `revisao_atual`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        @user_id,
        NOW()
    );

    -- Insere na tabela de conteúdo do log com a primeira revisão
    INSERT INTO `log_estoque_content` (
        `log_estoque_main_estoque_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `status_insumo`,
        `data_validade`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.id,
        1, -- Primeira revisão
        1, -- Ativo
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.status,
        NEW.data_validade,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_estoque` AFTER UPDATE ON `estoque` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_estoque_main
    UPDATE `log_estoque_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `estoque_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_estoque_main`
    WHERE `estoque_id` = OLD.id;

    -- Insere a nova versão na tabela log_estoque_content
    INSERT INTO `log_estoque_content` (
        `log_estoque_main_estoque_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `status_insumo`,
        `data_validade`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        1, -- Ativo
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.status,
        NEW.data_validade,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_estoque` AFTER DELETE ON `estoque` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualiza a revisão atual na tabela log_estoque_main
    UPDATE `log_estoque_main`
    SET revisao_atual = revisao_atual + 1
    WHERE `estoque_id` = OLD.id;

    -- Recupera a nova revisão
    SELECT revisao_atual INTO nova_revisao
    FROM `log_estoque_main`
    WHERE `estoque_id` = OLD.id;

    -- Insere a nova versão na tabela log_estoque_content com status de deletado
    INSERT INTO `log_estoque_content` (
        `log_estoque_main_estoque_id`,
        `revisao`,
        `status`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `status_insumo`,
        `data_validade`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.id,
        nova_revisao,
        0, -- Deletado
        OLD.insumos_id,
        OLD.quantidade,
        OLD.unidades_medida_id,
        OLD.status,
        OLD.data_validade,
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_pessoa_has_telefone` AFTER INSERT ON `pessoa_has_telefone` FOR EACH ROW
BEGIN
    INSERT INTO `log_pessoa_has_telefone` (
        `pessoa_id`,
        `telefone_id`,
        `acao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        NEW.pessoa_id,
        NEW.telefone_id,
        'INSERT',
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_pessoa_has_telefone` AFTER DELETE ON `pessoa_has_telefone` FOR EACH ROW
BEGIN
    INSERT INTO `log_pessoa_has_telefone` (
        `pessoa_id`,
        `telefone_id`,
        `acao`,
        `modificado_por`,
        `data_modificacao`
    ) VALUES (
        OLD.pessoa_id,
        OLD.telefone_id,
        'DELETE',
        @user_id,
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_valores_nutricionais` AFTER INSERT ON `valores_nutricionais` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT DEFAULT 1;

    -- Inserir na tabela main
    INSERT INTO `db_apae_estoque`.`log_valores_nutricionais_main` (`valores_nutricionais_insumos_id`, `revisao_atual`, `criado_por`)
    VALUES (NEW.insumos_id, nova_revisao, @user_id);

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_valores_nutricionais_content` (
        `log_valores_nutricionais_main_valores_nutricionais_insumos_id`,
        `revisao`,
        `porcao`,
        `calorias`,
        `carboidratros`,
        `proteinas`,
        `gorduras_totais`,
        `gorduras_saturadas`,
        `gorduras_trans`,
        `fibras`,
        `acucares`,
        `sodio`,
        `colesterol`,
        `calcio`,
        `ferro`,
        `potassio`,
        `vitamina_a`,
        `vitamina_c`,
        `vitamina_d`,
        `vitamina_e`,
        `vitamina_k`,
        `vitamina_b1`,
        `vitamina_b2`,
        `vitamina_b3`,
        `vitamina_b6`,
        `vitamina_b12`,
        `acido_folico`,
        `percentual_valor_diario`,
        `status`,
        `modificado_por`
    ) VALUES (
        NEW.insumos_id,
        nova_revisao,
        NEW.porcao,
        NEW.calorias,
        NEW.carboidratros,
        NEW.proteinas,
        NEW.gorduras_totais,
        NEW.gorduras_saturadas,
        NEW.gorduras_trans,
        NEW.fibras,
        NEW.acucares,
        NEW.sodio,
        NEW.colesterol,
        NEW.calcio,
        NEW.ferro,
        NEW.potassio,
        NEW.vitamina_a,
        NEW.vitamina_c,
        NEW.vitamina_d,
        NEW.vitamina_e,
        NEW.vitamina_k,
        NEW.vitamina_b1,
        NEW.vitamina_b2,
        NEW.vitamina_b3,
        NEW.vitamina_b6,
        NEW.vitamina_b12,
        NEW.acido_folico,
        NEW.percentual_valor_diario,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_valores_nutricionais` AFTER UPDATE ON `valores_nutricionais` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_valores_nutricionais_main`
                        WHERE `valores_nutricionais_insumos_id` = OLD.insumos_id);

    UPDATE `db_apae_estoque`.`log_valores_nutricionais_main`
    SET `revisao_atual` = nova_revisao
    WHERE `valores_nutricionais_insumos_id` = OLD.insumos_id;

    -- Inserir na tabela content
    INSERT INTO `db_apa_estoque`.`log_valores_nutricionais_content` (
        `log_valores_nutricionais_main_valores_nutricionais_insumos_id`,
        `revisao`,
        `porcao`,
        `calorias`,
        `carboidratros`,
        `proteinas`,
        `gorduras_totais`,
        `gorduras_saturadas`,
        `gorduras_trans`,
        `fibras`,
        `acucares`,
        `sodio`,
        `colesterol`,
        `calcio`,
        `ferro`,
        `potassio`,
        `vitamina_a`,
        `vitamina_c`,
        `vitamina_d`,
        `vitamina_e`,
        `vitamina_k`,
        `vitamina_b1`,
        `vitamina_b2`,
        `vitamina_b3`,
        `vitamina_b6`,
        `vitamina_b12`,
        `acido_folico`,
        `percentual_valor_diario`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.insumos_id,
        nova_revisao,
        NEW.porcao,
        NEW.calorias,
        NEW.carboidratros,
        NEW.proteinas,
        NEW.gorduras_totais,
        NEW.gorduras_saturadas,
        NEW.gorduras_trans,
        NEW.fibras,
        NEW.acucares,
        NEW.sodio,
        NEW.colesterol,
        NEW.calcio,
        NEW.ferro,
        NEW.potassio,
        NEW.vitamina_a,
        NEW.vitamina_c,
        NEW.vitamina_d,
        NEW.vitamina_e,
        NEW.vitamina_k,
        NEW.vitamina_b1,
        NEW.vitamina_b2,
        NEW.vitamina_b3,
        NEW.vitamina_b6,
        NEW.vitamina_b12,
        NEW.acido_folico,
        NEW.percentual_valor_diario,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_valores_nutricionais` AFTER DELETE ON `valores_nutricionais` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_valores_nutricionais_main`
                        WHERE `valores_nutricionais_insumos_id` = OLD.insumos_id);

    UPDATE `db_apae_estoque`.`log_valores_nutricionais_main`
    SET `revisao_atual` = nova_revisao
    WHERE `valores_nutricionais_insumos_id` = OLD.insumos_id;

    -- Inserir na tabela content com status de deletado
    INSERT INTO `db_apae_estoque`.`log_valores_nutricionais_content` (
        `log_valores_nutricionais_main_valores_nutricionais_insumos_id`,
        `revisao`,
        `porcao`,
        `calorias`,
        `carboidratros`,
        `proteinas`,
        `gorduras_totais`,
        `gorduras_saturadas`,
        `gorduras_trans`,
        `fibras`,
        `acucares`,
        `sodio`,
        `colesterol`,
        `calcio`,
        `ferro`,
        `potassio`,
        `vitamina_a`,
        `vitamina_c`,
        `vitamina_d`,
        `vitamina_e`,
        `vitamina_k`,
        `vitamina_b1`,
        `vitamina_b2`,
        `vitamina_b3`,
        `vitamina_b6`,
        `vitamina_b12`,
        `acido_folico`,
        `percentual_valor_diario`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.insumos_id,
        nova_revisao,
        OLD.porcao,
        OLD.calorias,
        OLD.carboidratros,
        OLD.proteinas,
        OLD.gorduras_totais,
        OLD.gorduras_saturadas,
        OLD.gorduras_trans,
        OLD.fibras,
        OLD.acucares,
        OLD.sodio,
        OLD.colesterol,
        OLD.calcio,
        OLD.ferro,
        OLD.potassio,
        OLD.vitamina_a,
        OLD.vitamina_c,
        OLD.vitamina_d,
        OLD.vitamina_e,
        OLD.vitamina_k,
        OLD.vitamina_b1,
        OLD.vitamina_b2,
        OLD.vitamina_b3,
        OLD.vitamina_b6,
        OLD.vitamina_b12,
        OLD.acido_folico,
        OLD.percentual_valor_diario,
        0,  -- Status "Deletado"
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_estoque_saida` AFTER INSERT ON `estoque_saida` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT DEFAULT 1;
    
    -- Inserir na tabela main
    INSERT INTO `db_apae_estoque`.`log_estoque_saida_main` (`estoque_saida_id`, `revisao_atual`, `criado_por`)
    VALUES (NEW.id, nova_revisao, @user_id);

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_estoque_saida_content` (
        `log_estoque_saida_main_estoque_saida_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_saida`,
        `observacao`,
        `status`,
        `modificado_por`
    ) VALUES (
        NEW.id,
        nova_revisao,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_saida,
        NEW.observacao,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_estoque_saida` AFTER UPDATE ON `estoque_saida` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_estoque_saida_main`
                        WHERE `estoque_saida_id` = OLD.id);
    
    UPDATE `db_apae_estoque`.`log_estoque_saida_main`
    SET `revisao_atual` = nova_revisao
    WHERE `estoque_saida_id` = OLD.id;
    
    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_estoque_saida_content` (
        `log_estoque_saida_main_estoque_saida_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_saida`,
        `observacao`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_saida,
        NEW.observacao,
        1,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_estoque_saida` AFTER DELETE ON `estoque_saida` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_estoque_saida_main`
                        WHERE `estoque_saida_id` = OLD.id);

    UPDATE `db_apae_estoque`.`log_estoque_saida_main`
    SET `revisao_atual` = nova_revisao
    WHERE `estoque_saida_id` = OLD.id;

    -- Inserir na tabela content com status de deletado
    INSERT INTO `db_apae_estoque`.`log_estoque_saida_content` (
        `log_estoque_saida_main_estoque_saida_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_saida`,
        `observacao`,
        `status`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        OLD.insumos_id,
        OLD.quantidade,
        OLD.unidades_medida_id,
        OLD.data_saida,
        OLD.observacao,
        0,  -- Status "Deletado"
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_estoque_vencido` AFTER INSERT ON `estoque_vencido` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT DEFAULT 1;
    
    -- Inserir na tabela main
    INSERT INTO `db_apae_estoque`.`log_estoque_vencido_main` (`estoque_vencido_id`, `revisao_atual`, `criado_por`)
    VALUES (NEW.id, nova_revisao, @user_id);

    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_estoque_vencido_content` (
        `log_estoque_vencido_main_estoque_vencido_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `descartado`,
        `status`,
        `data_movido`,
        `data_atualizado`,
        `modificado_por`
    ) VALUES (
        NEW.id,
        nova_revisao,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_validade,
        NEW.descartado,
        1,
        NEW.data_movido,
        NEW.data_atualizado,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_estoque_vencido` AFTER UPDATE ON `estoque_vencido` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;
    
    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_estoque_vencido_main`
                        WHERE `estoque_vencido_id` = OLD.id);
    
    UPDATE `db_apae_estoque`.`log_estoque_vencido_main`
    SET `revisao_atual` = nova_revisao
    WHERE `estoque_vencido_id` = OLD.id;
    
    -- Inserir na tabela content
    INSERT INTO `db_apae_estoque`.`log_estoque_vencido_content` (
        `log_estoque_vencido_main_estoque_vencido_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `descartado`,
        `status`,
        `data_movido`,
        `data_atualizado`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        NEW.insumos_id,
        NEW.quantidade,
        NEW.unidades_medida_id,
        NEW.data_validade,
        NEW.descartado,
        1,
        NEW.data_movido,
        NEW.data_atualizado,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_ad_log_estoque_vencido` AFTER DELETE ON `estoque_vencido` FOR EACH ROW
BEGIN
    DECLARE nova_revisao INT;

    -- Atualizar a revisão atual na tabela main
    SET nova_revisao = (SELECT `revisao_atual` + 1 FROM `db_apae_estoque`.`log_estoque_vencido_main`
                        WHERE `estoque_vencido_id` = OLD.id);

    UPDATE `db_apae_estoque`.`log_estoque_vencido_main`
    SET `revisao_atual` = nova_revisao
    WHERE `estoque_vencido_id` = OLD.id;

    -- Inserir na tabela content com status de deletado
    INSERT INTO `db_apae_estoque`.`log_estoque_vencido_content` (
        `log_estoque_vencido_main_estoque_vencido_id`,
        `revisao`,
        `insumos_id`,
        `quantidade`,
        `unidades_medida_id`,
        `data_validade`,
        `descartado`,
        `status`,
        `data_movido`,
        `data_atualizado`,
        `modificado_por`
    ) VALUES (
        OLD.id,
        nova_revisao,
        OLD.insumos_id,
        OLD.quantidade,
        OLD.unidades_medida_id,
        OLD.data_validade,
        OLD.descartado,
        0,  -- Status "Deletado"
        OLD.data_movido,
        OLD.data_atualizado,
        @user_id
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ai_doacoes_has_pedidos` AFTER INSERT ON `doacoes_has_pedidos` FOR EACH ROW
BEGIN
    -- Inserir na tabela de log
    INSERT INTO `log_doacoes_has_pedidos` (
        `doacoes_id`,
        `pedidos_id`,
        `acao`,
        `status`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.doacoes_id,
        NEW.pedidos_id,
        'INSERT',
        1, -- Status padrão como ativo
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_au_doacoes_has_pedidos` AFTER UPDATE ON `doacoes_has_pedidos` FOR EACH ROW
BEGIN
    -- Inserir na tabela de log indicando a ação de atualização
    INSERT INTO `log_doacoes_has_pedidos` (
        `doacoes_id`,
        `pedidos_id`,
        `acao`,
        `status`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        NEW.doacoes_id,
        NEW.pedidos_id,
        'UPDATE',
        1, -- Status padrão como ativo
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$

USE `db_apae_estoque`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_apae_estoque`.`trg_log_ad_doacoes_has_pedidos` AFTER DELETE ON `doacoes_has_pedidos` FOR EACH ROW
BEGIN
    -- Inserir na tabela de log indicando a ação de exclusão
    INSERT INTO `log_doacoes_has_pedidos` (
        `doacoes_id`,
        `pedidos_id`,
        `acao`,
        `status`,
        `criado_por`,
        `data_criado`
    ) VALUES (
        OLD.doacoes_id,
        OLD.pedidos_id,
        'DELETE',
        0, -- Marcar como deletado
        @user_id, -- ID do usuário que acionou o trigger
        NOW()
    );
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
