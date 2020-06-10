-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema EDUARDO_PEREIRA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EDUARDO_PEREIRA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EDUARDO_PEREIRA` DEFAULT CHARACTER SET utf8 ;
USE `EDUARDO_PEREIRA` ;

-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`RegistroAcademicoAluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `idRegistroAcademicoAluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aluno_RegistroAcademicoAluno1_idx` (`idRegistroAcademicoAluno` ASC),
  UNIQUE INDEX `idRegistroAcademicoAluno_UNIQUE` (`idRegistroAcademicoAluno` ASC),
  CONSTRAINT `fk_Aluno_RegistroAcademicoAluno1`
    FOREIGN KEY (`idRegistroAcademicoAluno`)
    REFERENCES `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Disciplina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`HistoricoGeracaoProva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataGeracao` DATE NOT NULL,
  `quantidadeProvas` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Prova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Prova` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numeroQuestoes` INT NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  `idDisciplina` INT NOT NULL,
  `idHistoricoGeracaoProva` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prova_Disciplina1_idx` (`idDisciplina` ASC),
  INDEX `fk_Prova_HistoricoGeracaoProva1_idx` (`idHistoricoGeracaoProva` ASC),
  CONSTRAINT `fk_Prova_Disciplina1`
    FOREIGN KEY (`idDisciplina`)
    REFERENCES `EDUARDO_PEREIRA`.`Disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prova_HistoricoGeracaoProva1`
    FOREIGN KEY (`idHistoricoGeracaoProva`)
    REFERENCES `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataAplicacao` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numeroAcertos` INT NOT NULL,
  `numeroErros` INT NOT NULL,
  `dataRealizacaoProva` DATE NOT NULL,
  `idAluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_HistoricoRealizacaoProva_Aluno1_idx` (`idAluno` ASC),
  CONSTRAINT `fk_HistoricoRealizacaoProva_Aluno1`
    FOREIGN KEY (`idAluno`)
    REFERENCES `EDUARDO_PEREIRA`.`Aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Tema` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Dificuldade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Dificuldade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NOT NULL,
  `valorQuestaoPercentual` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Questao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `enunciado` VARCHAR(255) NOT NULL,
  `idTema` INT NOT NULL,
  `idDificuldade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Questao_Tema1_idx` (`idTema` ASC),
  INDEX `fk_Questao_Dificuldade1_idx` (`idDificuldade` ASC),
  CONSTRAINT `fk_Questao_Tema1`
    FOREIGN KEY (`idTema`)
    REFERENCES `EDUARDO_PEREIRA`.`Tema` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Questao_Dificuldade1`
    FOREIGN KEY (`idDificuldade`)
    REFERENCES `EDUARDO_PEREIRA`.`Dificuldade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`QuestaoFechada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`QuestaoFechada` (
  `idQuestao` INT NOT NULL,
  `letraAlternativaCorreta` CHAR(1) NOT NULL,
  `quantidadeAcertos` INT NOT NULL,
  `quantidadeErros` INT NOT NULL,
  PRIMARY KEY (`idQuestao`),
  CONSTRAINT `fk_QuestaoFechada_Questao`
    FOREIGN KEY (`idQuestao`)
    REFERENCES `EDUARDO_PEREIRA`.`Questao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`QuestaoAberta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`QuestaoAberta` (
  `idQuestao` INT NOT NULL,
  `numeroLinhasResposta` INT NOT NULL,
  PRIMARY KEY (`idQuestao`),
  CONSTRAINT `fk_QuestaoAberta_Questao1`
    FOREIGN KEY (`idQuestao`)
    REFERENCES `EDUARDO_PEREIRA`.`Questao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Alternativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Alternativa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idProva` INT NOT NULL,
  `idHistoricoAplicacaoProva` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prova_HistoricoAplicacaoProva_Prova1_idx` (`idProva` ASC),
  INDEX `fk_Prova_HistoricoAplicacaoProva_HistoricoAplicacaoProva1_idx` (`idHistoricoAplicacaoProva` ASC),
  CONSTRAINT `fk_Prova_HistoricoAplicacaoProva_Prova1`
    FOREIGN KEY (`idProva`)
    REFERENCES `EDUARDO_PEREIRA`.`Prova` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prova_HistoricoAplicacaoProva_HistoricoAplicacaoProva1`
    FOREIGN KEY (`idHistoricoAplicacaoProva`)
    REFERENCES `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idHistoricoAplicacaoProva` INT NOT NULL,
  `idAluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aluno_HistoricoAplicacaoProva_HistoricoAplicacaoProva1_idx` (`idHistoricoAplicacaoProva` ASC),
  INDEX `fk_Aluno_HistoricoAplicacaoProva_Aluno1_idx` (`idAluno` ASC),
  CONSTRAINT `fk_Aluno_HistoricoAplicacaoProva_HistoricoAplicacaoProva1`
    FOREIGN KEY (`idHistoricoAplicacaoProva`)
    REFERENCES `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_HistoricoAplicacaoProva_Aluno1`
    FOREIGN KEY (`idAluno`)
    REFERENCES `EDUARDO_PEREIRA`.`Aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`Prova_Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`Prova_Questao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idProva` INT NOT NULL,
  `idQuestao` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prova_questao_Prova1_idx` (`idProva` ASC),
  INDEX `fk_Prova_questao_Questao1_idx` (`idQuestao` ASC),
  CONSTRAINT `fk_Prova_questao_Prova1`
    FOREIGN KEY (`idProva`)
    REFERENCES `EDUARDO_PEREIRA`.`Prova` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prova_questao_Questao1`
    FOREIGN KEY (`idQuestao`)
    REFERENCES `EDUARDO_PEREIRA`.`Questao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idQuestaoFechada` INT NOT NULL,
  `idAlternativa` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_QuestaoFechada_Alternativa_QuestaoFechada1_idx` (`idQuestaoFechada` ASC),
  INDEX `fk_QuestaoFechada_Alternativa_Alternativa1_idx` (`idAlternativa` ASC),
  CONSTRAINT `fk_QuestaoFechada_Alternativa_QuestaoFechada1`
    FOREIGN KEY (`idQuestaoFechada`)
    REFERENCES `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuestaoFechada_Alternativa_Alternativa1`
    FOREIGN KEY (`idAlternativa`)
    REFERENCES `EDUARDO_PEREIRA`.`Alternativa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



insert into `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`descricao`) values ('1A111111111');
insert into `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`descricao`) values ('1A222222222');
insert into `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`descricao`) values ('1A333333333');
insert into `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`descricao`) values ('1A444444444');
insert into `EDUARDO_PEREIRA`.`RegistroAcademicoAluno` (`descricao`) values ('1A555555555');

insert into `EDUARDO_PEREIRA`.`Aluno` (`nome`, `email`, `idRegistroAcademicoAluno`) values ('Aluno1', 'aluno1@email.com', 1);
insert into `EDUARDO_PEREIRA`.`Aluno` (`nome`, `email`, `idRegistroAcademicoAluno`) values ('Aluno2', 'aluno2@email.com', 2);
insert into `EDUARDO_PEREIRA`.`Aluno` (`nome`, `email`, `idRegistroAcademicoAluno`) values ('Aluno3', 'aluno3@email.com', 3);
insert into `EDUARDO_PEREIRA`.`Aluno` (`nome`, `email`, `idRegistroAcademicoAluno`) values ('Aluno4', 'aluno4@email.com', 4);
insert into `EDUARDO_PEREIRA`.`Aluno` (`nome`, `email`, `idRegistroAcademicoAluno`) values ('Aluno5', 'aluno5@email.com', 5);

insert into `EDUARDO_PEREIRA`.`Usuario` (`nome`, `email`, `login`, `senha`) values ('Usuario1', 'usuario1@email.com', 'login1', 'senha1');
insert into `EDUARDO_PEREIRA`.`Usuario` (`nome`, `email`, `login`, `senha`) values ('Usuario2', 'usuario2@email.com', 'login2', 'senha2');
insert into `EDUARDO_PEREIRA`.`Usuario` (`nome`, `email`, `login`, `senha`) values ('Usuario3', 'usuario3@email.com', 'login3', 'senha3');
insert into `EDUARDO_PEREIRA`.`Usuario` (`nome`, `email`, `login`, `senha`) values ('Usuario4', 'usuario4@email.com', 'login4', 'senha4');
insert into `EDUARDO_PEREIRA`.`Usuario` (`nome`, `email`, `login`, `senha`) values ('Usuario5', 'usuario5@email.com', 'login5', 'senha5');

insert into `EDUARDO_PEREIRA`.`Disciplina` (`descricao`) values ('disciplina1');
insert into `EDUARDO_PEREIRA`.`Disciplina` (`descricao`) values ('disciplina2');
insert into `EDUARDO_PEREIRA`.`Disciplina` (`descricao`) values ('disciplina3');
insert into `EDUARDO_PEREIRA`.`Disciplina` (`descricao`) values ('disciplina4');
insert into `EDUARDO_PEREIRA`.`Disciplina` (`descricao`) values ('disciplina5');

insert into `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`dataGeracao`, `quantidadeProvas`) values ('2018-09-01', 10);
insert into `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`dataGeracao`, `quantidadeProvas`) values ('2018-09-02', 20);
insert into `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`dataGeracao`, `quantidadeProvas`) values ('2018-09-03', 30);
insert into `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`dataGeracao`, `quantidadeProvas`) values ('2018-09-04', 40);
insert into `EDUARDO_PEREIRA`.`HistoricoGeracaoProva` (`dataGeracao`, `quantidadeProvas`) values ('2018-09-05', 50);

insert into `EDUARDO_PEREIRA`.`Prova` (`numeroQuestoes`, `valor`, `idDisciplina`, `idHistoricoGeracaoProva`) values (10, 10.0, 1, 1);
insert into `EDUARDO_PEREIRA`.`Prova` (`numeroQuestoes`, `valor`, `idDisciplina`, `idHistoricoGeracaoProva`) values (20, 20.0, 2, 2);
insert into `EDUARDO_PEREIRA`.`Prova` (`numeroQuestoes`, `valor`, `idDisciplina`, `idHistoricoGeracaoProva`) values (30, 30.0, 3, 3);
insert into `EDUARDO_PEREIRA`.`Prova` (`numeroQuestoes`, `valor`, `idDisciplina`, `idHistoricoGeracaoProva`) values (40, 40.0, 4, 4);
insert into `EDUARDO_PEREIRA`.`Prova` (`numeroQuestoes`, `valor`, `idDisciplina`, `idHistoricoGeracaoProva`) values (50, 50.0, 5, 5);

insert into `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`dataAplicacao`) values ('2018-10-01');
insert into `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`dataAplicacao`) values ('2018-10-02');
insert into `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`dataAplicacao`) values ('2018-10-03');
insert into `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`dataAplicacao`) values ('2018-10-04');
insert into `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva` (`dataAplicacao`) values ('2018-10-05');

insert into `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (`numeroAcertos`, `numeroErros`, `dataRealizacaoProva`, `idAluno`) values (5, 5, '2018-10-11', 1);
insert into `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (`numeroAcertos`, `numeroErros`, `dataRealizacaoProva`, `idAluno`) values (10, 10, '2018-10-12', 2);
insert into `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (`numeroAcertos`, `numeroErros`, `dataRealizacaoProva`, `idAluno`) values (15, 15, '2018-10-13', 3);
insert into `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (`numeroAcertos`, `numeroErros`, `dataRealizacaoProva`, `idAluno`) values (20, 20, '2018-10-14', 4);
insert into `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva` (`numeroAcertos`, `numeroErros`, `dataRealizacaoProva`, `idAluno`) values (25, 25, '2018-10-15', 5);

insert into `EDUARDO_PEREIRA`.`Tema` (`descricao`)  values ('Tema1');
insert into `EDUARDO_PEREIRA`.`Tema` (`descricao`)  values ('Tema2');
insert into `EDUARDO_PEREIRA`.`Tema` (`descricao`)  values ('Tema3');
insert into `EDUARDO_PEREIRA`.`Tema` (`descricao`)  values ('Tema4');
insert into `EDUARDO_PEREIRA`.`Tema` (`descricao`)  values ('Tema5');

insert into `EDUARDO_PEREIRA`.`Dificuldade` (`descricao`, `valorQuestaoPercentual`) values ('Muito Fácil', 1.0);
insert into `EDUARDO_PEREIRA`.`Dificuldade` (`descricao`, `valorQuestaoPercentual`) values ('Fácil', 2.0);
insert into `EDUARDO_PEREIRA`.`Dificuldade` (`descricao`, `valorQuestaoPercentual`) values ('Média', 3.0);
insert into `EDUARDO_PEREIRA`.`Dificuldade` (`descricao`, `valorQuestaoPercentual`) values ('Difícil', 4.0);
insert into `EDUARDO_PEREIRA`.`Dificuldade` (`descricao`, `valorQuestaoPercentual`) values ('Muito Difícil', 5.0);

insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 1', 1, 1);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 2', 2, 2);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 3', 3, 3);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 4', 4, 4);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 5', 5, 5);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 6', 1, 1);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 7', 2, 2);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 8', 3, 3);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 9', 4, 4);
insert into `EDUARDO_PEREIRA`.`Questao` (`enunciado`, `idTema`, `idDificuldade`) values ('Enunciado Questão 10', 5, 5);

insert into `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`, `letraAlternativaCorreta`, `quantidadeAcertos`, `quantidadeErros`) values (1, 'a', 50, 10);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`, `letraAlternativaCorreta`, `quantidadeAcertos`, `quantidadeErros`) values (2, 'b', 40, 20);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`, `letraAlternativaCorreta`, `quantidadeAcertos`, `quantidadeErros`) values (3, 'c', 30, 30);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`, `letraAlternativaCorreta`, `quantidadeAcertos`, `quantidadeErros`) values (4, 'd', 20, 40);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada` (`idQuestao`, `letraAlternativaCorreta`, `quantidadeAcertos`, `quantidadeErros`) values (5, 'e', 10, 50);

insert into `EDUARDO_PEREIRA`.`QuestaoAberta` (`idQuestao`, `numeroLinhasResposta`) values (6, 60);
insert into `EDUARDO_PEREIRA`.`QuestaoAberta` (`idQuestao`, `numeroLinhasResposta`) values (7, 70);
insert into `EDUARDO_PEREIRA`.`QuestaoAberta` (`idQuestao`, `numeroLinhasResposta`) values (8, 80);
insert into `EDUARDO_PEREIRA`.`QuestaoAberta` (`idQuestao`, `numeroLinhasResposta`) values (9, 90);
insert into `EDUARDO_PEREIRA`.`QuestaoAberta` (`idQuestao`, `numeroLinhasResposta`) values (10, 100);

insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 1');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 2');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 3');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 4');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 5');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 6');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 7');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 8');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 9');
insert into `EDUARDO_PEREIRA`.`Alternativa` (`descricao`) values ('Alternativa 10');

insert into `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (`idProva`, `idHistoricoAplicacaoProva`) values (1, 1);
insert into `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (`idProva`, `idHistoricoAplicacaoProva`) values (2, 2);
insert into `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (`idProva`, `idHistoricoAplicacaoProva`) values (3, 3);
insert into `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (`idProva`, `idHistoricoAplicacaoProva`) values (4, 4);
insert into `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva` (`idProva`, `idHistoricoAplicacaoProva`) values (5, 5);

insert into `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (`idHistoricoAplicacaoProva`, `idAluno`) values (1, 1);
insert into `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (`idHistoricoAplicacaoProva`, `idAluno`) values (2, 2);
insert into `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (`idHistoricoAplicacaoProva`, `idAluno`) values (3, 3);
insert into `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (`idHistoricoAplicacaoProva`, `idAluno`) values (4, 4);
insert into `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva` (`idHistoricoAplicacaoProva`, `idAluno`) values (5, 5);

insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (1, 1);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (2, 2);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (3, 3);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (4, 4);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (5, 5);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (1, 6);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (2, 7);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (3, 8);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (4, 9);
insert into `EDUARDO_PEREIRA`.`Prova_Questao` (`idProva`, `idQuestao`) values (5, 10);

insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (1, 1);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (2, 2);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (3, 3);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (4, 4);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (5, 5);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (1, 6);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (2, 7);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (3, 8);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (4, 9);
insert into `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa` (`idQuestaoFechada`, `idAlternativa`) values (5, 10);

/*
select * from `EDUARDO_PEREIRA`.`RegistroAcademicoAluno`;
select * from `EDUARDO_PEREIRA`.`Aluno`;
select * from `EDUARDO_PEREIRA`.`Usuario`;
select * from `EDUARDO_PEREIRA`.`Disciplina`;
select * from `EDUARDO_PEREIRA`.`HistoricoGeracaoProva`;
select * from `EDUARDO_PEREIRA`.`Prova`;
select * from `EDUARDO_PEREIRA`.`HistoricoAplicacaoProva`;
select * from `EDUARDO_PEREIRA`.`HistoricoRealizacaoProva`;
select * from `EDUARDO_PEREIRA`.`Tema`;
select * from `EDUARDO_PEREIRA`.`Dificuldade`;
select * from `EDUARDO_PEREIRA`.`Questao`;
select * from `EDUARDO_PEREIRA`.`QuestaoFechada`;
select * from `EDUARDO_PEREIRA`.`QuestaoAberta`;
select * from `EDUARDO_PEREIRA`.`Alternativa`;
select * from `EDUARDO_PEREIRA`.`Prova_HistoricoAplicacaoProva`;
select * from `EDUARDO_PEREIRA`.`Aluno_HistoricoAplicacaoProva`;
select * from `EDUARDO_PEREIRA`.`Prova_Questao`;
select * from `EDUARDO_PEREIRA`.`QuestaoFechada_Alternativa`;
*/