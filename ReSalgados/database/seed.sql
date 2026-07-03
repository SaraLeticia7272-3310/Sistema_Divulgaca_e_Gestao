-- PRODUTOS
INSERT INTO produto (
    categoria_id,
    nome,
    slug,
    descricao,
    preco,
    destaque
)
VALUES
(1,'Coxinha de Frango','coxinha-frango','Coxinha recheada com frango desfiado',7.50,TRUE),

(1,'Bolinha de Queijo','bolinha-queijo','Massa crocante recheada com queijo',7.00,TRUE),

(1,'Kibe','kibe','Kibe recheado com carne temperada',6.50,FALSE),

(2,'Esfirra de Carne','esfirra-carne','Esfirra assada tradicional',8.00,TRUE),

(2,'Enroladinho de Salsicha','enroladinho-salsicha','Massa macia com salsicha',6.50,FALSE);

--PRODUTOS DISPONIVEIS HOJE
INSERT INTO produto_disponivel(produto_id,data)
VALUES
(1,CURRENT_DATE),
(2,CURRENT_DATE),
(3,CURRENT_DATE);

--AVALIAÇÕES
INSERT INTO avaliacao
(nome,nota,comentario,aprovado)
VALUES

('Maria',5,'Os melhores salgados da cidade!',TRUE),

('João',5,'Muito saborosos e bem recheados.',TRUE),

('Ana',4,'Entrega rápida e atendimento excelente.',TRUE);

