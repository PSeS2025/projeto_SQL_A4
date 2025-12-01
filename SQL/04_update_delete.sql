-- =============================
-- 4. UPDATES E DELETES
-- =============================

UPDATE EXEMPLAR SET status = 'Emprestado' WHERE id_exemplar = 1;
UPDATE USUARIO SET email = 'novoemail@exemplo.com' WHERE id_usuario = 1;
UPDATE RESERVA SET status = 'Cancelada' WHERE id_reserva = 2;

DELETE FROM MULTA WHERE paga = TRUE;
DELETE FROM RESERVA WHERE status = 'Cancelada';
DELETE FROM EXEMPLAR WHERE id_obra = 1 AND status = 'Disponível';
