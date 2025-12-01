-- =============================
-- 3. SELECTS
-- =============================

SELECT nome, cpf, email FROM USUARIO ORDER BY nome ASC;

SELECT O.titulo, E.nome AS editora
FROM OBRA O JOIN EDITORA E ON O.id_editora = E.id_editora;

SELECT U.nome AS usuario, OB.titulo AS obra, EM.data_emprestimo
FROM EMPRESTIMO EM
JOIN USUARIO U ON EM.id_usuario = U.id_usuario
JOIN EXEMPLAR EX ON EM.id_exemplar = EX.id_exemplar
JOIN OBRA OB ON EX.id_obra = OB.id_obra
WHERE EM.status = 'Ativo';

SELECT R.id_reserva, O.titulo, R.data_reserva
FROM RESERVA R
JOIN OBRA O ON R.id_obra = O.id_obra
WHERE R.id_usuario = 3
ORDER BY R.data_reserva DESC;

SELECT M.id_multa, U.nome, M.valor, M.motivo
FROM MULTA M
JOIN EMPRESTIMO E ON M.id_emprestimo = E.id_emprestimo
JOIN USUARIO U ON E.id_usuario = U.id_usuario
WHERE M.paga = FALSE;
