DELIMITER $$

CREATE PROCEDURE generate_random_ids()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE random_id VARCHAR(10);
    DECLARE role ENUM('student', 'lecturer', 'admin');

    SET role = 'student';
    WHILE counter < 10 DO
        SET random_id = CONCAT(SUBSTRING(MD5(RAND()), 1, 8));
        INSERT INTO random_ids (random_id, role) VALUES (random_id, role);
        SET counter = counter + 1;
    END WHILE;

    SET counter = 0;
    SET role = 'lecturer';
    WHILE counter < 10 DO
        SET random_id = CONCAT(SUBSTRING(MD5(RAND()), 1, 8));
        INSERT INTO random_ids (random_id, role) VALUES (random_id, role);
        SET counter = counter + 1;
    END WHILE;

    SET counter = 0;
    SET role = 'admin';
    WHILE counter < 10 DO
        SET random_id = CONCAT(SUBSTRING(MD5(RAND()), 1, 8));
        INSERT INTO random_ids (random_id, role) VALUES (random_id, role);
        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

-- Call the procedure to generate and insert random IDs
CALL generate_random_ids();
