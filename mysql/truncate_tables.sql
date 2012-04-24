delimiter //
DROP PROCEDURE IF EXISTS truncate_tables//
CREATE PROCEDURE truncate_tables()
BEGIN
  DECLARE done int DEFAULT 1;
  DECLARE _table_name varchar(128);
  DECLARE cur CURSOR FOR
    SELECT table_name FROM information_schema.tables WHERE table_schema = DATABASE();
  DECLARE EXIT HANDLER FOR NOT FOUND SET done = 0;

  OPEN cur;
  WHILE done DO
    FETCH cur INTO _table_name;

    SET @sql = CONCAT('TRUNCATE TABLE ', _table_name);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END WHILE;
  CLOSE cur;
END
//
delimiter ;
