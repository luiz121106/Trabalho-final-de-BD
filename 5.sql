USE db_delivery_ifood;

DROP TRIGGER IF EXISTS tg_auditoria_pedido;

DELIMITER $$

CREATE TRIGGER tg_auditoria_pedido
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO historico_pedidos (id_pedido, id_cliente, id_restaurante, valor_total, acao)
    VALUES (NEW.id_pedido, NEW.id_cliente, NEW.id_restaurante, NEW.valor_total, 'INSERÇÃO DE NOVO PEDIDO');
END$$
DELIMITER ;

USE db_delivery_ifood;

SELECT * FROM historico_pedidos;
