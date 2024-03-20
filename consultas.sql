– CONSULTAS

-- Espaçonaves que têm uma massa máxima superior a 50000 e contar quantas vezes elas foram utilizadas em movimentações.
SELECT N.PLACA, COUNT(M.N_VOO) AS Total_Movimentacoes
FROM NAVE N
LEFT JOIN MOVIMENTACAO M ON N.PLACA = M.PLACA
WHERE N.MASSA_MAX > 50000
GROUP BY N.PLACA
HAVING COUNT(M.N_VOO) > 0;


-- PROJETAR O NOME DE TODOS OS PLANETAS E O CÓDIGO DE SEUS RESPECTIVOS 
ESPAÇO-PORTOS (COM INNER JOIN)
SELECT P.NOME_PLANETA, EP.CODIGO
FROM PLANETA P INNER JOIN 
	ESPACO_PORTO EP ON P.N_DO_SISTEMA = EP.N_DO_SISTEMA AND
	P.POSICAO = EP.POSICAO;


-- PROJETAR O NOME DE TODOS OS PLANETAS E AS COORDENADAS DE SEUS RESPECTIVOS SISTEMAS
SELECT P.NOME_PLANETA, S.COORDENADAS
FROM PLANETA P LEFT OUTER JOIN 
	SISTEMA S ON P.N_DO_SISTEMA = S.N_DO_SISTEMA;


-- Encontrar todas as naves que foram utilizadas em pelo menos uma movimentação.
SELECT n.PLACA, n.TIPO
FROM NAVE N
WHERE EXISTS (
    SELECT 1
    FROM MOVIMENTACAO M
    WHERE M.PLACA = N.PLACA
);

--Encontrar todos os pilotos que não foram registrados em nenhuma movimentação de naves
SELECT p.CGH
FROM PILOTO p
LEFT JOIN MOVIMENTACAO m ON p.CGH = m.CGH
WHERE m.CGH IS NULL;


--Encontrar o número total de naves registradas no sistema.
SELECT (
    SELECT COUNT(*)
    FROM NAVE
) AS Total_Naves
FROM DUAL;

--Obter informações sobre um espaço porto específico, incluindo o número total de funcionários associados a ele.
SELECT 
    EP.CODIGO,
    EP.DESCRICAO,
    EP.N_DO_SISTEMA,
    (
        SELECT COUNT(*)
        FROM EMPREGA Ef
        WHERE E.CODIGO = EP.CODIGO
    ) AS Total_Funcionarios
FROM ESPACO_PORTO EP
WHERE EP.CODIGO = 17;

--Encontrar todos os espaços portos que estão localizados em sistemas onde há pelo menos 5 planetas
SELECT *
FROM ESPACO_PORTO
WHERE N_DO_SISTEMA IN (
    SELECT N_DO_SISTEMA
    FROM PLANETA
    GROUP BY N_DO_SISTEMA
    HAVING COUNT(*) >= 5
);
