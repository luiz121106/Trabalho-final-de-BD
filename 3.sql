USE db_delivery_ifood;

DROP FUNCTION IF EXISTS fn_formatarCPF;
DROP FUNCTION IF EXISTS fn_formatarCNPJ;
DROP FUNCTION IF EXISTS fn_validarSenha;
DROP FUNCTION IF EXISTS fn_encriptarSenha;

DELIMITER $$

-- 1. Formata CPF (000.000.000-00)
CREATE FUNCTION fn_formatarCPF(p_cpf VARCHAR(20)) RETURNS VARCHAR(14) DETERMINISTIC
BEGIN
    DECLARE v_num VARCHAR(11);
    SET v_num = REGEXP_REPLACE(p_cpf, '[^0-9]', '');
    IF CHAR_LENGTH(v_num) = 11 THEN
        RETURN CONCAT(SUBSTRING(v_num,1,3), '.', SUBSTRING(v_num,4,3), '.', SUBSTRING(v_num,7,3), '-', SUBSTRING(v_num,10,2));
    ELSE
        RETURN p_cpf;
    END IF;
END$$

-- 2. Formata CNPJ (00.000.000/0000-00)
CREATE FUNCTION fn_formatarCNPJ(p_cnpj VARCHAR(25)) RETURNS VARCHAR(18) DETERMINISTIC
BEGIN
    DECLARE v_num VARCHAR(14);
    SET v_num = REGEXP_REPLACE(p_cnpj, '[^0-9]', '');
    IF CHAR_LENGTH(v_num) = 14 THEN
        RETURN CONCAT(SUBSTRING(v_num,1,2), '.', SUBSTRING(v_num,3,3), '.', SUBSTRING(v_num,6,3), '/', SUBSTRING(v_num,9,4), '-', SUBSTRING(v_num,13,2));
    ELSE
        RETURN p_cnpj;
    END IF;
END$$

-- 3. Valida Senha Forte (Mín 8 chars, letras e números)
CREATE FUNCTION fn_validarSenha(p_senha VARCHAR(255)) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    IF CHAR_LENGTH(p_senha) >= 8 AND p_senha REGEXP '[A-Za-z]' AND p_senha REGEXP '[0-9]' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END$$

-- 4. Encripta Senha com SHA-256
CREATE FUNCTION fn_encriptarSenha(p_senha VARCHAR(255)) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    RETURN SHA2(p_senha, 256);
END$$

DELIMITER ;

USE db_delivery_ifood;

SELECT 
    fn_formatarCPF('12345678901') AS Teste_CPF,
    fn_formatarCNPJ('12345678000190') AS Teste_CNPJ,
    fn_validarSenha('SenhaForte123') AS Teste_Senha_Forte,
    fn_validarSenha('fraca') AS Teste_Senha_Fraca,
    fn_encriptarSenha('123456') AS Teste_Criptografia;