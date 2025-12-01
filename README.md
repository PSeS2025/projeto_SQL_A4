# Biblioteca SQL

biblioteca-sql/
│
├── README.md
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_data.sql
│   ├── 03_select_queries.sql
│   ├── 04_update_delete.sql
└── 

1. Objetivo do Projeto

Desenvolver um banco de dados completo para gerenciamento de empréstimos, reservas, multas, obras e usuários de uma biblioteca acadêmica.

O projeto demonstra:
Modelagem conceitual e lógica
Normalização até a 3ª Forma Normal
Identificação de chaves primárias e estrangeiras
Criação de tabelas com integridade referencial
Consultas e manipulação de dados
Padrão adequado para apresentação acadêmica

🧩 2. Modelo Lógico (Resumo)
USUARIO
id_usuario (PK)
nome, cpf (UNIQUE), tipo, email, telefone, endereco, data_cadastro

FUNCIONARIO
id_funcionario (PK)
nome, matricula (UNIQUE), cargo, email

EDITORA
id_editora (PK)
nome, cnpj (UNIQUE)

AUTOR
id_autor (PK)
nome

OBRA
id_obra (PK)
titulo, ano, tipo_obra, isbn (UNIQUE)
id_editora (FK → EDITORA)

EXEMPLAR
id_exemplar (PK)
id_obra (FK → OBRA)
codigo_acesso (UNIQUE), status

OBRA_AUTOR (associativa N:N)
id_obra (FK)
id_autor (FK)
PK composta (id_obra, id_autor)

EMPRESTIMO
id_emprestimo (PK)
FKs: id_usuario, id_exemplar, id_funcionario
datas do processo e status

RESERVA
id_reserva (PK)
id_usuario (FK)
id_obra (FK)

MULTA
id_multa (PK)
id_emprestimo (FK)
valor, motivo, paga

3. Scripts SQL no Repositório

1. Criação de tabelas
01_create_tables.sql
Contém todas as definições DDL, chaves primárias, estrangeiras e índices.

2. Inserção de dados

02_insert_data.sql
Povoa as tabelas principais com registros realistas.
Inclui:
SELECT com JOIN
WHERE
ORDER BY
LIMIT
Busca por obras, usuários, empréstimos etc.

4. Atualizações e exclusões

04_update_delete.sql
Inclui:
3 comandos de UPDATE
3 comandos de DELETE
Todos com condições usando WHERE.

4. Diagramas

Os diagramas estão na pasta /docs, em PNG e/ou SVG:
diagrama_DER.svg
diagrama_logico.svg
Eles destacam:
🔑 PK (Primary Key)
🔗 FK (Foreign Key)
Relacionamentos 1:N e N:N
Atributos principais

▶️ 5. Como Executar o Projeto
1. Criar o banco e tabelas
SOURCE sql/01_create_tables.sql;

2. Inserir dados
SOURCE sql/02_insert.sql;

3. Executar consultas
SOURCE sql/03_select.sql;

4. Executar updates e deletes
SOURCE sql/04_update_delete.sql;


