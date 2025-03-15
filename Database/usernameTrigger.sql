DELIMITER //

CREATE TRIGGER update_email_before_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	SET NEW.username = CONCAT(NEW.name, '@uenr.edu');
END //

CREATE TRIGGER update_email_before_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	SET NEW.username = CONCAT(NEW.name, '@uenr.edu');
END //

DELIMITER ;