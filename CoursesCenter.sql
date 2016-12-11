/*
	Data.........: 28/08/2016
	Descrição....: Criação das tabelas do projeto
	Arquivo......: CoursesCenter.sql
	Autor........: Ricardo Rinco
*/

-- Criação do banco de dados: CoursesCenter
CREATE DATABASE CoursesCenter;
USE CoursesCenter;

-- Criação da tabela: Tipo de Curso
CREATE TABLE CourseType (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
	Identification VARCHAR(50) NOT NULL, -- Identificação do Tipo de Curso
	
    CONSTRAINT pk_CourseTypeId PRIMARY KEY(Id), -- Define o campo Id como chave primária
    
    -- Índices
    INDEX idx_CourseTypeId(Id) -- Define o campo Id do Tipo de Curso como um índice
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Criação da tabela: Instrutor
CREATE TABLE Instructor (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
	Identification VARCHAR(50) NOT NULL, -- Identificação do Instrutor
	
    CONSTRAINT pk_Instructor_InstructorId PRIMARY KEY(Id), -- Define o campo Id como chave primária
    
    -- Índices
    INDEX idx_InstructorId(Id) -- Define o campo Id do Instrutor como um índice
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Criação da tabela: Curso
CREATE TABLE Course (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
	Identification VARCHAR(100) NOT NULL, -- Identificação do Curso
	Price DOUBLE NOT NULL, -- Valor do curso
    CourseTypeId INTEGER UNSIGNED NOT NULL, -- Id do Tipo de Curso
	InstructorId INTEGER UNSIGNED NOT NULL, -- Id do Instrutor
	
    CONSTRAINT pk_CourseId PRIMARY KEY(Id), -- Define o campo Id como chave primária
	CONSTRAINT fk_Course_CourseTypeId FOREIGN KEY(CourseTypeId) REFERENCES CourseType(Id), -- Cria o relacionamento (chave estrangeira) com a tabela Tipo de Curso
	CONSTRAINT fk_Course_InstructorId FOREIGN KEY(InstructorId) REFERENCES Instructor(Id), -- Cria o relacionamento (chave estrangeira) com a tabela Instrutor
    
    -- Índices
    INDEX idx_fk_Course_CourseTypeId(CourseTypeId), -- Define o campo Id do Tipo de Curso como um índice
	INDEX idx_fk_Course_InstructorId(InstructorId) -- Define o campo Id do Instrutor como um índice
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Criação da tabela: Aluno
CREATE TABLE Student (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
	Identification VARCHAR(100) NOT NULL, -- Identificação do Aluno
    BirthDate DATE NOT NULL, -- Data de Aniversário do Aluno
	Email VARCHAR(128) NOT NULL, -- E-mail do Aluno
	Registration INTEGER NOT NULL, -- Número da matrícula do Aluno
    
    CONSTRAINT pk_StudentId PRIMARY KEY(Id), -- Define o campo Id como chave primária
    
    -- Índices
    INDEX idx_StudentId(Id) -- Define o campo Id do Aluno como um índice
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Criação da tabela: Pedido
CREATE TABLE Request (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
	RequestDateTime DATETIME DEFAULT now(), -- Data e hora do Pedido
    StudentId INTEGER UNSIGNED NOT NULL, -- Id do Aluno
	
	CONSTRAINT pk_RequestId PRIMARY KEY(Id), -- Define o campo Id como chave primária
    CONSTRAINT fk_Request_StudentId FOREIGN KEY(StudentId) REFERENCES Student(Id), -- Cria o relacionamento (chave estrangeira) com a tabela Aluno
	
    -- Índices
    INDEX idx_RequestId(Id), -- Define o campo Id como um índice
    INDEX idx_fk_Request_StudentIdo(StudentId) -- Define o campo Id do Aluno como um índice
	
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Criação da tabela: Detalhes do Pedido
CREATE TABLE RequestDetail (
	Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, -- Código de identificação interno
    RequestId INTEGER UNSIGNED NOT NULL, -- Id do Pedido
	CourseId INTEGER UNSIGNED NOT NULL, -- Id do Curso
    
    CONSTRAINT pk_RequestDetailId PRIMARY KEY(Id), -- Define o campo Id como chave primária
    CONSTRAINT fk_Request_RequestId FOREIGN KEY(RequestId) REFERENCES Request(Id), -- Cria o relacionamento (chave estrangeira) com a tabela Pedido
    CONSTRAINT fk_Course_CourseId FOREIGN KEY(CourseId) REFERENCES Course(Id), -- Cria o relacionamento (chave estrangeira) com a tabela Curso
    
    -- Índices
    INDEX idx_RequestDetailId(Id), -- Define o campo Id como um índice
	INDEX idx_fk_RequestDetail_RequestId(RequestId), -- Define o campo Id do Pedido como um índice
	INDEX idx_fk_RequestDetail_CourseId(CourseId) -- Define o campo Id do Curso como um índice
) ENGINE = innodb DEFAULT CHARSET = latin1 COLLATE = latin1_general_ci;

-- Inserindo dados na tabela: Tipo de Curso
INSERT INTO CourseType (Identification)
VALUES ('Introdutórios'),
('Banco de Dados'),
('Programação'),
('Infraestrutura'),
('Engenharia de Software'),
('Cálculo');

-- Inserindo dados na tabela: Instrutor
INSERT INTO Instructor (Identification)
VALUES ('José da Silva Martins'),
('Juliana Pinheiros'),
('Robson de Souza'),
('Marlene Queiroz'),
('Fábio Prado'),
('Antônio Carlos'),
('Wellington Mendez'),
('Marco Bento'),
('Joaquim Silva'),
('André Gomes');

-- Inserindo dados na tabela: Curso
INSERT INTO Course (Identification, Price, CourseTypeId, InstructorId)
VALUES ('Fundamentos em Análise e Desenvolvimento de Sistemas', 80.90, 1, 1),
('Introdução à Computação', 80.90, 1, 7),
('Introdução à Engenharia de Software', 80.90, 1, 2),
('Algorítmos', 80.90, 1, 2),
('Análise de Algorítmos', 80.90, 1, 2),
('Matemática Aplicada à Computação', 108.80, 6, 4),
('Probabilidade e Estatística', 80.90, 6, 4),
('Cálculo Numérico', 108.80, 6, 4),
('Cálculo I', 108.80, 6, 4),
('Cálculo II', 108.80, 6, 4),
('Cálculo III', 108.80, 6, 4),
('Lógica Matemática', 108.80, 6, 7),
('Banco de Dados I', 160.30, 2, 7),
('Banco de Dados II', 160.30, 2, 5),
('Estrutura de Dados I', 160.30, 2, 7),
('Estrutura de Dados II', 160.30, 2, 5),
('Linguagem de Programação I', 398.50, 3, 5),
('Linguagem de Programação II', 398.50, 3, 3),
('Linguagem de Programação III', 398.50, 3, 3),
('Linguagem de Programação IV', 398.50, 3, 5),
('Linguagem de Programação V', 398.50, 3, 5),
('Programação WEB I', 398.50, 3, 3),
('Programação WEB II', 398.50, 3, 5),
('Programação WEB III', 398.50, 3, 5),
('Programação de Computadores I', 398.50, 3, 3),
('Programação de Computadores II', 398.50, 3, 5),
('Programação de Computadores III', 398.50, 3, 5),
('Programação de Computadores IV', 398.50, 3, 5),
('Paradigmas de Linguagens de Programação', 398.50, 3, 5),
('Redes de Computadores', 250.90, 4, 6),
('Administração e Segurança de Redes', 250.90, 4, 6),
('Arquitetura e Organização de Computadores', 250.90, 4, 6),
('Sistemas Distribuídos', 250.90, 4, 7),
('Sistemas Operacionais', 250.90, 4, 6),
('Interação Humano-Computador', 250.90, 4, 1),
('Compiladores', 250.90, 4, 8),
('Inteligência Artificial', 250.90, 4, 8),
('Multimídia e Computação Gráfica', 250.90, 4, 8),
('Teoria da Computação I', 250.90, 4, 8),
('Teoria da Computação II', 250.90, 4, 8),
('Gestão de Tecnologia de Informação', 530.10, 5, 2),
('Engenharia de Software I', 530.10, 5, 7),
('Engenharia de Software II', 530.10, 5, 7),
('Qualidade e Auditoria de Software', 530.10, 5, 2),
('Gestão de Projetos', 530.10, 5, 1);