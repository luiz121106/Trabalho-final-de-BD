-- ============================================================================
-- Criação do Banco de Dados e Estrutura de Tabelas (Esquema)
-- Cenário: Ecossistema de Delivery (Estilo iFood)
-- SGBD: MySQL 8.0+
-- ============================================================================

-- 1. CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_delivery_ifood;
USE db_delivery_ifood;

-- Limpeza prévia das tabelas em ordem inversa das chaves estrangeiras (evita erros de restrição)
DROP TABLE IF EXISTS sac_reclamacoes;
DROP TABLE IF EXISTS historico_pedidos;
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS restaurantes;
DROP TABLE IF EXISTS entregadores;
DROP TABLE IF EXISTS usuarios;

-- ============================================================================
-- 2. CRIAÇÃO DAS TABELAS
-- ============================================================================

-- TABELA: usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL, -- Espaço para o hash criptográfico
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(15),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario),
    CONSTRAINT uk_usuarios_email UNIQUE (email),
    CONSTRAINT uk_usuarios_cpf UNIQUE (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- TABELA: entregadores
CREATE TABLE entregadores (
    id_entregador INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    cnh VARCHAR(15) NOT NULL,
    veiculo_tipo ENUM('Moto', 'Carro', 'Bicicleta') NOT NULL,
    veiculo_placa VARCHAR(7) NULL,
    status_disponibilidade BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_entregadores PRIMARY KEY (id_entregador),
    CONSTRAINT uk_entregadores_cpf UNIQUE (cpf),
    CONSTRAINT uk_entregadores_cnh UNIQUE (cnh),
    CONSTRAINT uk_entregadores_placa UNIQUE (veiculo_placa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- TABELA: restaurantes
CREATE TABLE restaurantes (
    id_restaurante INT AUTO_INCREMENT,
    nome_fantasia VARCHAR(100) NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    regiao VARCHAR(50) NOT NULL, 
    data_abertura DATE NOT NULL,
    CONSTRAINT pk_restaurantes PRIMARY KEY (id_restaurante),
    CONSTRAINT uk_restaurantes_cnpj UNIQUE (cnpj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- TABELA: produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT,
    id_restaurante INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_produtos PRIMARY KEY (id_produto),
    CONSTRAINT fk_produtos_restaurantes FOREIGN KEY (id_restaurante) 
        REFERENCES restaurantes (id_restaurante) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- TABELA: pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_restaurante INT NOT NULL,
    id_entregador INT NULL, 
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_entrega ENUM('Pendente', 'Em Preparo', 'A Caminho', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    taxa_entrega DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    taxa_servico DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedidos_usuarios FOREIGN KEY (id_cliente) 
        REFERENCES usuarios (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pedidos_restaurantes FOREIGN KEY (id_restaurante) 
        REFERENCES restaurantes (id_restaurante) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pedidos_entregadores FOREIGN KEY (id_entregador) 
        REFERENCES entregadores (id_entregador) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- RNF04: Índices para otimização de consultas por data e região
CREATE INDEX idx_pedidos_data ON pedidos (data_pedido);
CREATE INDEX idx_restaurantes_regiao ON restaurantes (regiao);

-- TABELA: itens_pedido (Relacionamento N:M)
CREATE TABLE itens_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_itens_pedido PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_itens_pedido_pedidos FOREIGN KEY (id_pedido) 
        REFERENCES pedidos (id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_itens_pedido_produtos FOREIGN KEY (id_produto) 
        REFERENCES produtos (id_produto) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- TABELA: sac_reclamacoes
CREATE TABLE sac_reclamacoes (
    id_reclamacao INT AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_pedido INT NULL, 
    tipo ENUM('Dúvida', 'Reclamação', 'Elogio') NOT NULL,
    descricao TEXT NOT NULL,
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_sac_reclamacoes PRIMARY KEY (id_reclamacao),
    CONSTRAINT fk_sac_reclamacoes_usuarios FOREIGN KEY (id_usuario) 
        REFERENCES usuarios (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sac_reclamacoes_pedidos FOREIGN KEY (id_pedido) 
        REFERENCES pedidos (id_pedido) ON DELETE SET NULL ON UPDATE CASCADE
) 

ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


Show tables