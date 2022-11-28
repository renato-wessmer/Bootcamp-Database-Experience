-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa` (
  `idpessoa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  `nmeio` VARCHAR(20) NULL,
  `sobrenome` VARCHAR(20) NOT NULL,
  `cpf` VARCHAR(15) NOT NULL,
  `rua` VARCHAR(20) NOT NULL,
  `bairro` VARCHAR(15) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idpessoa`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `pessoa_idpessoa` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_pessoa1_idx` (`pessoa_idpessoa` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_pessoa1`
    FOREIGN KEY (`pessoa_idpessoa`)
    REFERENCES `mydb`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`veiculo` (
  `idveiculo` INT NOT NULL AUTO_INCREMENT,
  `fabricante` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NULL,
  `portas` INT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idveiculo`, `cliente_idcliente`),
  INDEX `fk_veiculo_cliente_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagamento` (
  `idpagamento` INT NOT NULL AUTO_INCREMENT,
  `formadepagamento` ENUM('A VISTA', 'credito', 'debito', 'pix', 'não pago') NOT NULL DEFAULT 'não pago',
  `valor` FLOAT NOT NULL,
  `data` DATE NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpagamento`, `cliente_idcliente`),
  INDEX `fk_pagamento_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tecnico` (
  `idTecnico` INT NOT NULL AUTO_INCREMENT,
  `especialidade` VARCHAR(45) NOT NULL,
  `pessoa_idpessoa` INT NOT NULL,
  PRIMARY KEY (`idTecnico`),
  INDEX `fk_Tecnico_pessoa1_idx` (`pessoa_idpessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Tecnico_pessoa1`
    FOREIGN KEY (`pessoa_idpessoa`)
    REFERENCES `mydb`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `Tecnico_idTecnico` INT NOT NULL,
  PRIMARY KEY (`idDepartamento`, `Tecnico_idTecnico`),
  INDEX `fk_Departamento_Tecnico1_idx` (`Tecnico_idTecnico` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Tecnico1`
    FOREIGN KEY (`Tecnico_idTecnico`)
    REFERENCES `mydb`.`Tecnico` (`idTecnico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`serviço` (
  `idproduto` INT NOT NULL,
  `descrição` VARCHAR(45) NOT NULL,
  `preço` FLOAT NOT NULL,
  `horas` TIME NOT NULL,
  `Tecnico_idTecnico` INT NOT NULL,
  PRIMARY KEY (`idproduto`, `Tecnico_idTecnico`),
  INDEX `fk_serviço_Tecnico1_idx` (`Tecnico_idTecnico` ASC) VISIBLE,
  CONSTRAINT `fk_serviço_Tecnico1`
    FOREIGN KEY (`Tecnico_idTecnico`)
    REFERENCES `mydb`.`Tecnico` (`idTecnico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`analise de veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`analise de veiculo` (
  `idanalise` INT NOT NULL AUTO_INCREMENT,
  `veiculo_idveiculo` INT NOT NULL,
  `tipo de serviço` VARCHAR(45) NULL,
  `descrição` VARCHAR(200) NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  `serviço_idproduto` INT NOT NULL,
  PRIMARY KEY (`idanalise`, `veiculo_idveiculo`, `Departamento_idDepartamento`, `serviço_idproduto`),
  INDEX `fk_Departamento_has_veiculo_veiculo1_idx` (`veiculo_idveiculo` ASC) VISIBLE,
  INDEX `fk_analise de veiculo_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_analise de veiculo_serviço1_idx` (`serviço_idproduto` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_has_veiculo_veiculo1`
    FOREIGN KEY (`veiculo_idveiculo`)
    REFERENCES `mydb`.`veiculo` (`idveiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_analise de veiculo_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_analise de veiculo_serviço1`
    FOREIGN KEY (`serviço_idproduto`)
    REFERENCES `mydb`.`serviço` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem de Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Serviço` (
  `idOrdem de Serviço` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `data de entrega` DATE NOT NULL,
  `descrição` VARCHAR(200) NOT NULL,
  `valor` FLOAT NOT NULL,
  `pagamento_idpagamento` INT NOT NULL,
  `data de emissao` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `analise de veiculo_idanalise` INT NOT NULL,
  PRIMARY KEY (`idOrdem de Serviço`, `cliente_idcliente`, `pagamento_idpagamento`, `analise de veiculo_idanalise`),
  INDEX `fk_Ordem de Serviço_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_pagamento1_idx` (`pagamento_idpagamento` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_analise de veiculo1_idx` (`analise de veiculo_idanalise` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_pagamento1`
    FOREIGN KEY (`pagamento_idpagamento`)
    REFERENCES `mydb`.`pagamento` (`idpagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_analise de veiculo1`
    FOREIGN KEY (`analise de veiculo_idanalise`)
    REFERENCES `mydb`.`analise de veiculo` (`idanalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `idprodutos` INT NOT NULL,
  `preco` FLOAT NOT NULL,
  `qunatidade` INT NOT NULL,
  `descrição` VARCHAR(45) NULL,
  PRIMARY KEY (`idprodutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `cliente_idcliente` INT NOT NULL,
  `produtos_idprodutos` INT NOT NULL,
  `valor` FLOAT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`cliente_idcliente`, `produtos_idprodutos`),
  INDEX `fk_cliente_has_produtos_produtos1_idx` (`produtos_idprodutos` ASC) VISIBLE,
  INDEX `fk_cliente_has_produtos_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_produtos_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_produtos_produtos1`
    FOREIGN KEY (`produtos_idprodutos`)
    REFERENCES `mydb`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
