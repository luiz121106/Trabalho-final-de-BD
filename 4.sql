USE db_delivery_ifood;

DROP PROCEDURE IF EXISTS sp_cadastrarCliente;
DROP PROCEDURE IF EXISTS sp_cadastrarEntregador;
DROP PROCEDURE IF EXISTS sp_cadastrarProduto;
DROP PROCEDURE IF EXISTS sp_cadastrarPedido;

DELIMITER $$

-- 1. Cadastro de Clientes (Usa validação e criptografia)
CREATE PROCEDURE sp_cadastrarCliente(
    IN p_nome VARCHAR(100), IN p_email VARCHAR(100), IN p_senha VARCHAR(255), 
    IN p_cpf VARCHAR(20), IN p_telefone VARCHAR(15)
)
BEGIN
    IF fn_validarSenha(p_senha) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Senha fraca. Use mínimo 8 caracteres com letras e números.';
    END IF;
    INSERT INTO usuarios (nome, email, senha, cpf, telefone)
    VALUES (p_nome, p_email, fn_encriptarSenha(p_senha), fn_formatarCPF(p_cpf), p_telefone);
END$$

-- 2. Cadastro de Entregadores (Formatação automática)
CREATE PROCEDURE sp_cadastrarEntregador(
    IN p_nome VARCHAR(100), IN p_cpf VARCHAR(20), IN p_cnh VARCHAR(15), 
    IN p_veiculo_tipo ENUM('Moto', 'Carro', 'Bicicleta'), IN p_veiculo_placa VARCHAR(7)
)
BEGIN
    INSERT INTO entregadores (nome, cpf, cnh, veiculo_tipo, veiculo_placa)
    VALUES (p_nome, fn_formatarCPF(p_cpf), p_cnh, p_veiculo_tipo, p_veiculo_placa);
END$$

-- 3. Cadastro de Produtos (Validação de preços)
CREATE PROCEDURE sp_cadastrarProduto(
    IN p_id_restaurante INT, IN p_nome VARCHAR(100), IN p_preco DECIMAL(10,2), 
    IN p_categoria VARCHAR(50), IN p_estoque INT
)
BEGIN
    IF p_preco <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Preço inválido. Deve ser maior que zero.';
    END IF;
    INSERT INTO produtos (id_restaurante, nome, preco, categoria, quantidade_estoque)
    VALUES (p_id_restaurante, p_nome, p_preco, p_categoria, p_estoque);
END$$

-- 4. Cadastro de Pedido (Verifica estoque e calcula total)
CREATE PROCEDURE sp_cadastrarPedido(
    IN p_id_cliente INT, IN p_id_restaurante INT, IN p_id_produto INT, 
    IN p_quantidade INT, IN p_taxa_entrega DECIMAL(10,2), IN p_taxa_servico DECIMAL(10,2)
)
BEGIN
    DECLARE v_estoque_atual INT;
    DECLARE v_preco_unitario DECIMAL(10,2);
    DECLARE v_valor_total DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    -- Pega dados do produto
    SELECT quantidade_estoque, preco INTO v_estoque_atual, v_preco_unitario
    FROM produtos WHERE id_produto = p_id_produto;

    -- Validações
    IF v_estoque_atual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Produto não encontrado.';
    END IF;
    IF v_estoque_atual < p_quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Estoque insuficiente.';
    END IF;

    -- Regra de Negócio: Total = (Preço * Qtd) + Taxas
    SET v_valor_total = (v_preco_unitario * p_quantidade) + p_taxa_entrega + p_taxa_servico;

    -- Insere Pedido (Capa)
    INSERT INTO pedidos (id_cliente, id_restaurante, taxa_entrega, taxa_servico, valor_total)
    VALUES (p_id_cliente, p_id_restaurante, p_taxa_entrega, p_taxa_servico, v_valor_total);
    
    SET v_id_pedido = LAST_INSERT_ID();

    -- Insere Itens (Corpo)
    INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
    VALUES (v_id_pedido, p_id_produto, p_quantidade, v_preco_unitario);

    -- Atualiza Estoque (Baixa)
    UPDATE produtos SET quantidade_estoque = quantidade_estoque - p_quantidade
    WHERE id_produto = p_id_produto;
END$$

DELIMITER ;