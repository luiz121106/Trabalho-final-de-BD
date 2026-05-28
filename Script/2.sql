-- ============================================================================
-- 02_dml_inserts.sql
-- Carga Inicial de Dados, Updates e Deletes Exemplares
-- Cenário: Ecossistema de Delivery (Estilo iFood)
-- SGBD: MySQL 8.0+
-- ============================================================================

USE db_delivery_ifood;

-- Desativa temporariamente a verificação de chaves para permitir uma carga limpa
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE sac_reclamacoes;
TRUNCATE TABLE itens_pedido;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE produtos;
TRUNCATE TABLE restaurantes;
TRUNCATE TABLE entregadores;
TRUNCATE TABLE usuarios;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================================
-- 1. POPULANDO A TABELA: usuarios (20 Clientes)
-- ============================================================================
INSERT INTO usuarios (id_usuario, nome, email, senha, cpf, telefone) VALUES
(1, 'Carlos Silva', 'carlos.silva@email.com', 'SenhaForte123', '111.111.111-11', '(11) 98888-1111'),
(2, 'Ana Oliveira', 'ana.oliveira@email.com', 'Ana123456!', '222.222.222-22', '(11) 98888-2222'),
(3, 'Bruno Santos', 'bruno.santos@email.com', 'Mudar@2026', '333.333.333-33', '(21) 97777-3333'),
(4, 'Mariana Lima', 'mariana.lima@email.com', 'Mari#2026', '444.444.444-44', '(21) 97777-4444'),
(5, 'Rodrigo Souza', 'rodrigo.souza@email.com', 'Rodrigo99', '555.555.555-55', '(31) 96666-5555'),
(6, 'Juliana Costa', 'juliana.costa@email.com', 'JuJu_2026', '666.666.666-66', '(31) 96666-6666'),
(7, 'Gabriel Alves', 'gabriel.alves@email.com', 'Gabi102030', '777.777.777-77', '(51) 95555-7777'),
(8, 'Amanda Rocha', 'amanda.rocha@email.com', 'Ama@Rocha', '888.888.888-88', '(51) 95555-8888'),
(9, 'Lucas Martins', 'lucas.martins@email.com', 'LucasPass', '999.999.999-99', '(61) 94444-9999'),
(10, 'Beatriz Gomes', 'beatriz.gomes@email.com', 'Bia#Gomes', '000.000.000-00', '(61) 94444-0000'),
(11, 'Felipe Vieira', 'felipe.vieira@email.com', 'Felipao88', '123.456.789-10', '(11) 91111-2222'),
(12, 'Camila Ribeiro', 'camila.ribeiro@email.com', 'Cami_Rib', '234.567.890-12', '(11) 92222-3333'),
(13, 'Pedro Henrique', 'pedro.henrique@email.com', 'PedroP@ss', '345.678.901-23', '(21) 93333-4444'),
(14, 'Larissa Melo', 'larissa.melo@email.com', 'LariM2026', '456.789.012-34', '(21) 94444-5555'),
(15, 'Thiago Cardoso', 'thiago.cardoso@email.com', 'ThiCard1', '567.890.123-45', '(31) 95555-6666'),
(16, 'Fernanda Dias', 'fernanda.dias@email.com', 'Fer_Dias!', '678.890.123-56', '(31) 96666-7777'),
(17, 'Gustavo Neves', 'gustavo.neves@email.com', 'GusNeves9', '789.901.234-67', '(51) 97777-8888'),
(18, 'Patricia Cruz', 'patricia.cruz@email.com', 'Paty@Cruz', '890.012.345-78', '(51) 98888-9999'),
(19, 'Rafael Fonseca', 'rafael.fonseca@email.com', 'RafaF2026', '901.123.456-89', '(61) 99999-0000'),
(20, 'Isabela Araujo', 'isabela.araujo@email.com', 'Isa_Araujo', '012.234.567-90', '(61) 91234-5678');

-- ============================================================================
-- 2. POPULANDO A TABELA: entregadores (20 Entregadores)
-- ============================================================================
INSERT INTO entregadores (id_entregador, nome, cpf, cnh, veiculo_tipo, veiculo_placa, status_disponibilidade) VALUES
(1, 'Ricardo Motoboy', '111.222.333-44', '11122233344', 'Moto', 'ABC1D23', TRUE),
(2, 'Marcos Entrega', '222.333.444-55', '22233344455', 'Moto', 'XYZ9X87', TRUE),
(3, 'Diego Ciclista', '333.444.555-66', '33344455566', 'Bicicleta', NULL, TRUE),
(4, 'Andre Carro', '444.555.666-77', '44455566677', 'Carro', 'KGB5M41', TRUE),
(5, 'Fabio Veloz', '555.666.777-88', '55566677788', 'Moto', 'MNO2P34', TRUE),
(6, 'Guilherme Bike', '666.777.888-99', '66677788899', 'Bicicleta', NULL, TRUE),
(7, 'Alexandre Silva', '777.888.999-00', '77788899900', 'Moto', 'QWE7R89', TRUE),
(8, 'Eduardo Lima', '888.999.000-11', '88899900011', 'Carro', 'DFR4T56', TRUE),
(9, 'Sandro Souza', '999.000.111-22', '99900011122', 'Moto', 'TYU1U23', FALSE),
(10, 'Roberto Carlos', '000.111.222-33', '00011122233', 'Moto', 'IOP9O87', TRUE),
(11, 'Marcelo Vieira', '123.123.123-12', '12312312312', 'Bicicleta', NULL, TRUE),
(12, 'Vanderlei Cordeiro', '234.234.234-23', '23423423423', 'Moto', 'VND5F67', TRUE),
(13, 'Wellington Rosa', '345.345.345-34', '34534534534', 'Moto', 'WLT2R99', TRUE),
(14, 'Danilo Ramos', '456.456.456-45', '45645645645', 'Carro', 'DNL8H12', TRUE),
(15, 'Samuel Braga', '567.567.567-56', '56756756756', 'Moto', 'SML3B45', TRUE),
(16, 'Mauricio Neto', '678.678.678-67', '67867867867', 'Bicicleta', NULL, TRUE),
(17, 'Otavio Augusto', '789.789.789-78', '78978978978', 'Moto', 'OTV4G88', TRUE),
(18, 'Claudio Facundo', '890.890.890-89', '89089089089', 'Moto', 'CLD1A22', FALSE),
(19, 'Renan Nobre', '901.901.901-90', '90190190190', 'Carro', 'RNN7V34', TRUE),
(20, 'Igor Carvalho', '012.012.012-01', '01201201201', 'Moto', 'IGR0C11', TRUE);

-- ============================================================================
-- 3. POPULANDO A TABELA: restaurantes (20 Restaurantes)
-- Inclui: Foster, MC, BK, Girafas, Bobs e complementos estratégicos
-- ============================================================================
INSERT INTO restaurantes (id_restaurante, nome_fantasia, razao_social, cnpj, regiao, data_abertura) VALUES
(1, 'Foster Hamburgueria', 'Foster Alimentos LTDA', '11.111.111/0001-11', 'Zona Sul', '2020-01-15'),
(2, 'McDonalds - MC Centro', 'Arcos Dorados Alimentos SA', '22.222.222/0001-22', 'Centro', '2015-05-10'),
(3, 'Burger King - BK Shopping', 'BK Brasil Restaurantes SA', '33.333.333/0001-33', 'Zona Norte', '2017-08-22'),
(4, 'Girafas Grelhados', 'Girafas Franquias SA', '44.444.444/0001-44', 'Zona Oeste', '2016-11-04'),
(5, 'Bobs Shakes e Burgers', 'BFF Cia de Alimentos', '55.555.555/0001-55', 'Zona Sul', '2014-03-30'),
(6, 'Subway Sanduiches', 'Sub Alimentos do Brasil LTDA', '66.666.666/0001-66', 'Centro', '2018-09-12'),
(7, 'Pizza Hut', 'International Meal Company S.A.', '77.777.777/0001-77', 'Zona Norte', '2019-02-25'),
(8, 'China in Box', 'TrendFoods Francas LTDA', '88.888.888/0001-88', 'Zona Oeste', '2015-07-14'),
(9, 'Habibs Esfihas', 'Alsaraiva Comercio de Alimentos LTDA', '99.999.999/0001-99', 'Centro', '2013-10-05'),
(10, 'Outback Steakhouse', 'Bloomin Brands Resto SA', '00.000.000/0001-00', 'Zona Sul', '2012-04-18'),
(11, 'Sushiloko', 'Loko de Sushi Alimentos ME', '12.345.678/0001-90', 'Zona Oeste', '2021-06-01'),
(12, 'Madero Container', 'Madero Industria e Comercio SA', '23.456.789/0001-01', 'Zona Sul', '2020-11-20'),
(13, 'KFC Frango Frito', 'KFC Brazil Franchising Eireli', '34.567.890/0001-12', 'Zona Norte', '2018-12-05'),
(14, 'Ragazzo Massas', 'Albe Comercio de Alimentos', '45.678.901/0001-23', 'Centro', '2016-04-15'),
(15, 'Coco Bambu', 'Coco Bambu Restaurantes LTDA', '56.789.012/0001-34', 'Zona Sul', '2011-08-25'),
(16, 'Domino''s Pizza', 'Alsea Brasil Restos LTDA', '67.890.123/0001-45', 'Zona Oeste', '2017-03-10'),
(17, 'Starbucks Café', 'SouthRock Cafe Brasil S.A.', '77.890.123/0001-56', 'Centro', '2019-05-18'),
(18, 'Cacau Show Mega', 'Cacau Show Franquias LTDA', '88.901.234/0001-67', 'Zona Norte', '2020-02-12'),
(19, 'Spoleto Massas', 'Grupo Trigo SA', '99.012.345/0001-78', 'Zona Oeste', '2015-09-09'),
(20, 'Koni Store', 'Koni Alimentos Gastronomia', '00.123.456/0001-89', 'Zona Sul', '2016-07-22');

-- ============================================================================
-- 4. POPULANDO A TABELA: produtos (23 Itens de Cardápio)
-- ============================================================================
INSERT INTO produtos (id_produto, id_restaurante, nome, preco, categoria, quantidade_estoque) VALUES
(1, 1, 'Foster Classic Burger', 34.90, 'Burgers', 50),
(2, 1, 'Batata Frita Rústica', 14.50, 'Acompanhamentos', 100),
(3, 2, 'Big Mac', 24.90, 'Burgers', 200),
(4, 2, 'Batata Frita Média', 11.90, 'Acompanhamentos', 500),
(5, 2, 'Sundae de Chocolate', 8.50, 'Sobremesas', 150),
(6, 3, 'Whopper Especial', 26.90, 'Burgers', 180),
(7, 3, 'Onion Rings Crocantes', 13.90, 'Acompanhamentos', 90),
(8, 4, 'Prato Executivo Frango', 29.90, 'Pratos', 60),
(9, 4, 'Petit Gateau Girafas', 14.90, 'Sobremesas', 40),
(10, 5, 'Big Bob Hamburguer', 22.50, 'Burgers', 120),
(11, 5, 'Milkshake Ovaltine 500ml', 16.90, 'Bebidas', 300),
(12, 6, 'Subway Footlong', 21.00, 'Sanduiches', 110),
(13, 7, 'Pizza Pepperoni Grande', 59.90, 'Pizzas', 45),
(14, 8, 'Yakisoba Tradicional Box', 32.00, 'Comida Oriental', 80),
(15, 9, 'Combo 10 Esfihas Carne', 19.90, 'Salgados', 1000),
(16, 10, 'Ribs on the Barbie', 89.90, 'Carnes', 35),
(17, 11, 'Combo Hot Filadelfia 16un', 39.90, 'Comida Oriental', 70),
(18, 12, 'Madero Bacon Burger', 42.00, 'Burgers', 55),
(19, 13, 'Balde Frango Frito', 49.90, 'Frangos', 120),
(20, 14, 'Coxinha de Frango Ragazzo', 2.50, 'Salgados', 2000),
(21, 15, 'Camarão Internacional', 149.00, 'Frutos do Mar', 20),
(22, 16, 'Pizza Quatro Queijos M', 44.90, 'Pizzas', 60),
(23, 17, 'Frappuccino Mocha G', 19.50, 'Cafeteria', 150);

-- ============================================================================
-- 5. POPULANDO A TABELA: pedidos (20 Pedidos)
-- ============================================================================
INSERT INTO pedidos (id_pedido, id_cliente, id_restaurante, id_entregador, status_entrega, taxa_entrega, taxa_servico, valor_total) VALUES
(1, 1, 1, 1, 'Entregue', 5.00, 2.00, 41.90),
(2, 2, 2, 2, 'Entregue', 7.00, 2.00, 45.80),
(3, 3, 3, 4, 'Entregue', 6.50, 2.50, 49.80),
(4, 4, 4, 5, 'A Caminho', 8.00, 2.00, 39.90),
(5, 5, 5, 7, 'Em Preparo', 4.50, 1.50, 45.40),
(6, 6, 6, 8, 'Pendente', 5.50, 2.00, 28.50),
(7, 7, 7, 10, 'Entregue', 9.00, 3.00, 71.90),
(8, 8, 8, 12, 'Cancelado', 6.00, 2.00, 40.00),
(9, 9, 9, 13, 'Entregue', 4.00, 1.50, 25.40),
(10, 10, 10, 14, 'Entregue', 12.00, 5.00, 106.90),
(11, 11, 11, 15, 'A Caminho', 7.50, 2.50, 49.90),
(12, 12, 12, 17, 'Em Preparo', 6.00, 2.00, 50.00),
(13, 13, 13, 19, 'Pendente', 8.50, 3.00, 61.40),
(14, 14, 14, 1, 'Entregue', 3.00, 1.00, 11.50),
(15, 15, 15, 2, 'Entregue', 15.00, 7.00, 171.00),
(16, 16, 16, 4, 'Entregue', 6.50, 2.50, 53.90),
(17, 17, 17, 5, 'Cancelado', 5.00, 2.00, 26.50),
(18, 1, 1, 7, 'Entregue', 5.00, 2.00, 56.40),
(19, 2, 2, 8, 'Entregue', 7.00, 2.00, 33.90),
(20, 3, 3, 10, 'Entregue', 6.50, 2.50, 35.90);

-- ============================================================================
-- 6. POPULANDO A TABELA: itens_pedido (Produtos vinculados aos pedidos)
-- ============================================================================
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 34.90),
(2, 3, 1, 24.90),
(2, 4, 1, 11.90),
(3, 6, 1, 26.90),
(3, 7, 1, 13.90),
(4, 8, 1, 29.90),
(5, 10, 1, 22.50),
(5, 11, 1, 16.90),
(6, 12, 1, 21.00),
(7, 13, 1, 59.90),
(8, 14, 1, 32.00),
(9, 15, 1, 19.90),
(10, 16, 1, 89.90),
(11, 17, 1, 39.90),
(12, 18, 1, 42.00),
(13, 19, 1, 49.90),
(14, 20, 3, 2.50),
(15, 21, 1, 149.00),
(16, 22, 1, 44.90),
(17, 23, 1, 19.50),
(18, 1, 1, 34.90),
(18, 2, 1, 14.50),
(19, 3, 1, 24.90),
(20, 6, 1, 26.90);

-- ============================================================================
-- 7. EXEMPLOS DE UPDATES EXAMPLARES (Exigência do Professor)
-- ============================================================================

-- Update 1: Atualizar o status de um pedido que foi entregue
UPDATE pedidos SET status_entrega = 'Entregue' WHERE id_pedido = 4;

-- Update 2: Mudar disponibilidade do entregador
UPDATE entregadores SET status_disponibilidade = FALSE WHERE id_entregador = 3;

-- Update 3: Ajuste de preço do cardápio devido à inflação
UPDATE produtos SET preco = 36.90 WHERE id_produto = 1;

-- Update 4: Cliente atualizou o telefone de contato
UPDATE usuarios SET telefone = '(11) 99999-8888' WHERE id_usuario = 1;

-- Update 5: Reabastecimento de estoque de produto do McDonald's
UPDATE produtos SET quantidade_estoque = quantidade_estoque + 100 WHERE id_produto = 4;

-- ============================================================================
-- 8. EXEMPLOS DE DELETES EXEMPLARES (Exigência do Professor)
-- Para testar deletes sem violar chaves estrangeiras ativas, criamos registros temporários e apagamos:
-- ============================================================================

USE db_delivery_ifood;

-- ============================================================================
-- 8. EXEMPLOS DE DELETES EXEMPLARES (CORRIGIDO)
-- ============================================================================

-- Inserindo e deletando Usuário de teste (CPF alterado)
INSERT INTO usuarios (id_usuario, nome, email, senha, cpf, telefone) 
VALUES (99, 'Deletar', 'del@email.com', '123', '999.888.777-66', '0');

DELETE FROM usuarios WHERE id_usuario = 99;

-- Inserindo e deletando Produto de teste
INSERT INTO produtos (id_produto, id_restaurante, nome, preco, categoria, quantidade_estoque) 
VALUES (99, 1, 'Suco de Jaca Descontinuado', 7.00, 'Bebidas', 0);

DELETE FROM produtos WHERE id_produto = 99;

-- Inserindo e deletando Entregador de teste (CPF alterado)
INSERT INTO entregadores (id_entregador, nome, cpf, cnh, veiculo_tipo, veiculo_placa) 
VALUES (99, 'Entregador Desistente', '888.777.666-55', '00000000', 'Bicicleta', NULL);

DELETE FROM entregadores WHERE id_entregador = 99;

-- Inserindo e deletando Chamado do SAC de teste
INSERT INTO sac_reclamacoes (id_reclamacao, id_usuario, tipo, descricao) 
VALUES (99, 2, 'Dúvida', 'App aceita Pix?');

DELETE FROM sac_reclamacoes WHERE id_reclamacao = 99;

-- Inserindo e deletando Restaurante de teste (CNPJ alterado)
INSERT INTO restaurantes (id_restaurante, nome_fantasia, razao_social, cnpj, regiao, data_abertura) 
VALUES (99, 'Resto Fake', 'Fake LTDA', '10.200.300/0001-99', 'Centro', '2026-01-01');

DELETE FROM restaurantes WHERE id_restaurante = 99;