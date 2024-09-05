-- Certifique-se de que os eventos estão ativados no MySQL
SHOW VARIABLES LIKE 'event_scheduler';

-- Se o event_scheduler estiver desativado (OFF), você pode ativá-lo com:
SET GLOBAL event_scheduler = ON;

-- Cria Evento
DELIMITER $$

CREATE EVENT IF NOT EXISTS `event_atualizar_status_estoque`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    -- Definir @user_id como um valor que indica operação automática
    SET @user_id = -1;

    -- Atualizar status para 'Vence hoje' (3) se a data de validade for igual à data atual
    UPDATE `db_apae_estoque`.`estoque`
    SET `status` = 3
    WHERE `data_validade` = CURRENT_DATE;

    -- Atualizar status para 'Vencido' (4) se a data de validade for menor que a data atual
    UPDATE `db_apae_estoque`.`estoque`
    SET `status` = 4
    WHERE `data_validade` < CURRENT_DATE;
END$$

DELIMITER ;
