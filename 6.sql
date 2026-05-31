USE db_delivery_ifood;

DROP VIEW IF EXISTS vw_relatorio_regional;

CREATE VIEW vw_relatorio_regional AS
SELECT 
    r.regiao AS Regiao_Restaurante,
    DATE_FORMAT(p.data_pedido, '%Y-%m') AS Periodo,
    prod.categoria AS Tipo_Item,
    SUM(p.valor_total) AS Faturamento_Total,
    COUNT(p.id_pedido) AS Quantidade_Pedidos
FROM pedidos p
JOIN restaurantes r ON p.id_restaurante = r.id_restaurante
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos prod ON ip.id_produto = prod.id_produto
GROUP BY r.regiao, DATE_FORMAT(p.data_pedido, '%Y-%m'), prod.categoria;

SELECT * FROM vw_relatorio_regional;