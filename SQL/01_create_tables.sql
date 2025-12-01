-- ===========================================
-- ARQUIVO SQL COMPLETO PARA IMPORTAÇÃO NO SQLDBM
-- Inclui:
-- 1. Criação das tabelas (Modelo Lógico)
-- 2. Inserts para povoamento
-- 3. Consultas SELECT
-- 4. Updates e Deletes
-- ===========================================

-- =============================
-- 1. CREATE TABLES
-- =============================

DROP TABLE IF EXISTS obra_autor;
DROP TABLE IF EXISTS multa;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS exemplar;
DROP TABLE IF EXISTS obra;
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS editora;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS usuario;

-- Tabelas principais
CREATE TABLE usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cpf CHAR(11) UNIQUE,
  tipo ENUM('aluno','professor','funcionario') NOT NULL,
  email VARCHAR(320),
  telefone VARCHAR(30),
  endereco TEXT,
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE funcionario (
  id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  matricula VARCHAR(50) UNIQUE NOT NULL,
  cargo VARCHAR(100),
  email VARCHAR(320)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE editora (
  id_editora INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cnpj VARCHAR(20) UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE autor (
  id_autor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE obra (
  id_obra INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(500) NOT NULL,
  ano SMALLINT,
  tipo_obra ENUM('livro','revista','tese','e-book') NOT NULL,
  isbn VARCHAR(20) UNIQUE,
  id_editora INT,
  CONSTRAINT fk_obra_editora FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE exemplar (
  id_exemplar INT AUTO_INCREMENT PRIMARY KEY,
  id_obra INT NOT NULL,
  codigo_acesso VARCHAR(100) UNIQUE NOT NULL,
  status ENUM('disponivel','emprestado','reservado','perdido') NOT NULL DEFAULT 'disponivel',
  CONSTRAINT fk_exemplar_obra FOREIGN KEY (id_obra) REFERENCES obra(id_obra)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE emprestimo (
  id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_exemplar INT NOT NULL,
  id_funcionario INT,
  data_emprestimo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_prevista_devolucao DATE NOT NULL,
  data_devolucao DATE,
  status ENUM('ativo','devolvido','atrasado') NOT NULL DEFAULT 'ativo',
  CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_emprestimo_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE reserva (
  id_reserva INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_obra INT NOT NULL,
  data_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status ENUM('ativa','atendida','expirada') NOT NULL DEFAULT 'ativa',
  CONSTRAINT fk_reserva_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_reserva_obra FOREIGN KEY (id_obra) REFERENCES obra(id_obra)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Multa em forma normalizada (3FN): referencia apenas emprestimo
CREATE TABLE multa (
  id_multa INT AUTO_INCREMENT PRIMARY KEY,
  id_emprestimo INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),
  motivo ENUM('atraso','dano','extravio','outro') NOT NULL,
  paga BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT fk_multa_emprestimo FOREIGN KEY (id_emprestimo) REFERENCES emprestimo(id_emprestimo)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela associativa N:N obra <-> autor
CREATE TABLE obra_autor (
  id_obra INT NOT NULL,
  id_autor INT NOT NULL,
  ordem_autoria SMALLINT,
  PRIMARY KEY (id_obra, id_autor),
  CONSTRAINT fk_obra_autor_obra FOREIGN KEY (id_obra) REFERENCES obra(id_obra)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_obra_autor_autor FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Índices sugeridos
CREATE INDEX idx_obra_titulo ON obra (titulo(200));
CREATE INDEX idx_exemplar_obra ON exemplar (id_obra);
CREATE INDEX idx_emprestimo_usuario ON emprestimo (id_usuario);
CREATE INDEX idx_emprestimo_exemplar ON emprestimo (id_exemplar);
CREATE INDEX idx_reserva_obra ON reserva (id_obra);
