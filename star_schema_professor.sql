CREATE DATABASE db_star_schema_universidade;

SHOW DATABASES;

USE db_star_schema_universidade;

/* =========================
   DIMENSÕES
   ========================= */

CREATE TABLE dim_professor (
    sk_professor INT AUTO_INCREMENT PRIMARY KEY,
    nk_id_professor INT NOT NULL,
    registro VARCHAR(45) NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE dim_pessoa (
    sk_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    nk_id_pessoa INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(90) NOT NULL,
    cidade VARCHAR(45),
    estado CHAR(2),
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE dim_disciplina (
    sk_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nk_id_disciplina INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(45),
    carga_horaria TIME NOT NULL
);

CREATE TABLE dim_departamento (
    sk_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nk_id_departamento INT NOT NULL,
    sigla VARCHAR(45) NOT NULL,
    descricao VARCHAR(45)
);

CREATE TABLE dim_universidade (
    sk_universidade INT AUTO_INCREMENT PRIMARY KEY,
    nk_id_universidade INT NOT NULL,
    sigla VARCHAR(45) NOT NULL,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE dim_periodo (
    sk_periodo INT AUTO_INCREMENT PRIMARY KEY,
    ano YEAR NOT NULL,
    semestre INT NOT NULL,
    CONSTRAINT uk_dim_periodo UNIQUE (ano, semestre)
);

/* =========================
   TABELA FATO
   ========================= */

CREATE TABLE fato_professor (
    sk_fato_professor INT AUTO_INCREMENT PRIMARY KEY,

    sk_professor INT NOT NULL,
    sk_pessoa INT NOT NULL,
    sk_disciplina INT NOT NULL,
    sk_departamento INT NOT NULL,
    sk_universidade INT NOT NULL,
    sk_periodo INT NOT NULL,

    carga_horaria TIME NOT NULL,
    qtd_alunos INT NOT NULL,
    qtd_disciplinas INT NOT NULL,

    CONSTRAINT fk_fato_professor_professor
        FOREIGN KEY (sk_professor)
        REFERENCES dim_professor (sk_professor),

    CONSTRAINT fk_fato_professor_pessoa
        FOREIGN KEY (sk_pessoa)
        REFERENCES dim_pessoa (sk_pessoa),

    CONSTRAINT fk_fato_professor_disciplina
        FOREIGN KEY (sk_disciplina)
        REFERENCES dim_disciplina (sk_disciplina),

    CONSTRAINT fk_fato_professor_departamento
        FOREIGN KEY (sk_departamento)
        REFERENCES dim_departamento (sk_departamento),

    CONSTRAINT fk_fato_professor_universidade
        FOREIGN KEY (sk_universidade)
        REFERENCES dim_universidade (sk_universidade),

    CONSTRAINT fk_fato_professor_periodo
        FOREIGN KEY (sk_periodo)
        REFERENCES dim_periodo (sk_periodo)
);