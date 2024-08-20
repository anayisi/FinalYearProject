TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER update_email_before_insert\nBEFORE INSERT ON user_details\nFOR EACH ROW\nBEGIN\n	SET NEW.username = CONCAT(NEW.name, \'@uenr.edu\');\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER update_email_before_update\nBEFORE UPDATE ON user_details\nFOR EACH ROW\nBEGIN\n	SET NEW.username = CONCAT(NEW.name, \'@uenr.edu\');\nEND'
sql_modes=1098907648 1098907648
definers='root@localhost' 'root@localhost'
client_cs_names='utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_unicode_ci' 'utf8mb4_unicode_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
created=1720081863660962 1720082009278865
