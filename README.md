# 🚀 Projeto Final: Sistema de Delivery (Estilo iFood)

Este repositório contém a arquitetura completa de um banco de dados relacional desenvolvido no MySQL 8.0 para gerenciar um ecossistema de delivery, englobando restaurantes, clientes, entregadores, produtos, SAC e o processamento financeiro e operacional de pedidos.

## 📂 Estrutura de Pastas e Arquivos
O projeto está organizado da seguinte forma:

* `/docs`
    * `RELATÓRIO TÉCNICO_ SISTEMA DE DELIVERY.pdf`: Documentação com as justificativas de modelagem e escolhas técnicas.
* `/scripts` (Ordem de execução dos scripts no MySQL)
    1.  `1.sql` - Criação do Banco de Dados e tabelas estruturais.
    2.  `2.sql` - Carga inicial de dados fictícios para testes, exemplos de UPDATE e DELETE.
    3.  `3.sql` - Funções determinísticas para formatação (CPF/CNPJ) e segurança.
    4.  `4.sql` - Stored Procedures para automação de cadastros e regras de negócio de pedidos.
    5.  `5.sql` - Trigger para auditoria automática do histórico de compras.
    6.  `6.sql` - View gerencial de faturamento regional e script de testes integrados.

## 🛠️ Tecnologias e Técnicas Utilizadas
* **SGBD:** MySQL 8.0+ (Engine InnoDB para suporte a chaves estrangeiras e transações).
* **Segurança da Informação:** Mascaramento de dados sensíveis e criptografia de senhas com algoritmo Hash SHA-256 via Functions.
* **Automação Operacional:** Redução de chamadas da aplicação através de Stored Procedures acionadas por parâmetros.
* **Integridade e Auditoria:** Rastreabilidade completa de novos pedidos através de gatilhos (Triggers).
* **Inteligência de Negócio (BI):** Consolidação de métricas e indicadores de faturamento por região por meio de Views otimizadas.

## 🎥 Demonstração Prática
Assista ao vídeo explicativo com a execução passo a passo de todos os scripts e objetos funcionando no MySQL Workbench:

(https://youtu.be/jf8pNe-Qujk)
