-- ReSalgados.sql
-- PostgreSQL 16+
-- Crie o banco "ReSalgados" no pgAdmin e execute este script conectado a ele.

DROP TABLE IF EXISTS promocao CASCADE;
DROP TABLE IF EXISTS horario_funcionamento CASCADE;
DROP TABLE IF EXISTS avaliacao CASCADE;
DROP TABLE IF EXISTS produto_disponivel CASCADE;
DROP TABLE IF EXISTS midia CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS configuracao CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;

CREATE TABLE usuario(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(150) UNIQUE NOT NULL,
 senha VARCHAR(255) NOT NULL,
 foto VARCHAR(255),
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 ultimo_login TIMESTAMP,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categoria(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nome VARCHAR(100) UNIQUE NOT NULL,
 slug VARCHAR(150) UNIQUE NOT NULL,
 descricao TEXT,
 icone VARCHAR(100),
 ordem INT DEFAULT 0,
 ativo BOOLEAN DEFAULT TRUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produto(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 categoria_id INT NOT NULL REFERENCES categoria(id) ON DELETE RESTRICT,
 nome VARCHAR(120) NOT NULL,
 slug VARCHAR(150) UNIQUE NOT NULL,
 descricao TEXT,
 preco NUMERIC(10,2),
 unidade VARCHAR(20) DEFAULT 'unidade',
 destaque BOOLEAN DEFAULT FALSE,
 ativo BOOLEAN DEFAULT TRUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE midia(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 produto_id INT REFERENCES produto(id) ON DELETE CASCADE,
 tipo VARCHAR(20) NOT NULL CHECK(tipo IN ('produto','banner','galeria')),
 caminho VARCHAR(255) NOT NULL,
 ordem INT DEFAULT 0,
 ativo BOOLEAN DEFAULT TRUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produto_disponivel(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 produto_id INT NOT NULL REFERENCES produto(id) ON DELETE CASCADE,
 data DATE NOT NULL,
 observacao TEXT,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE avaliacao(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(150),
 nota INT NOT NULL CHECK(nota BETWEEN 1 AND 5),
 comentario TEXT NOT NULL,
 aprovado BOOLEAN DEFAULT FALSE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE configuracao(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nome_empresa VARCHAR(150) NOT NULL,
 telefone VARCHAR(30),
 whatsapp VARCHAR(30),
 instagram VARCHAR(150),
 email VARCHAR(150),
 endereco TEXT,
 horario VARCHAR(150),
 descricao TEXT,
 logo VARCHAR(255),
 favicon VARCHAR(255),
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE horario_funcionamento(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 dia_semana SMALLINT NOT NULL CHECK(dia_semana BETWEEN 0 AND 6),
 abre TIME,
 fecha TIME,
 fechado BOOLEAN DEFAULT FALSE
);

CREATE TABLE promocao(
 id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 titulo VARCHAR(150) NOT NULL,
 descricao TEXT,
 imagem VARCHAR(255),
 data_inicio DATE NOT NULL,
 data_fim DATE NOT NULL,
 ativo BOOLEAN DEFAULT TRUE,
 usuario_id INT REFERENCES usuario(id) ON DELETE SET NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_produto_categoria ON produto(categoria_id);
CREATE INDEX idx_produto_slug ON produto(slug);
CREATE INDEX idx_categoria_slug ON categoria(slug);
CREATE INDEX idx_disponivel_data ON produto_disponivel(data);

INSERT INTO categoria(nome,slug,descricao) VALUES
('Fritos','fritos','Salgados fritos'),
('Assados','assados','Salgados assados'),
('Doces','doces','Salgados doces'),
('Combos','combos','Combos e promoções');

INSERT INTO configuracao(nome_empresa) VALUES ('Re Salgados');

INSERT INTO horario_funcionamento(dia_semana,abre,fecha,fechado) VALUES
(1,'13:00','18:00',FALSE),
(2,'13:00','18:00',FALSE),
(3,'13:00','18:00',FALSE),
(4,'13:00','18:00',FALSE),
(5,'13:00','18:00',FALSE),
(6,'13:00','18:00',FALSE),
(0,NULL,NULL,TRUE);

-- Gere um hash com password_hash() e insira o administrador:
-- INSERT INTO usuario(nome,email,senha)
-- VALUES ('Sara','admin@resalgados.com','HASH_GERADO_PELO_PHP');
