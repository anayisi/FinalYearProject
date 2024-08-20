TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER before_insert_administrators\nBEFORE INSERT ON administrators\nFOR EACH ROW\nBEGIN\n    IF NEW.admin_id IS NULL THEN\n        SET NEW.admin_id = IFNULL((SELECT MAX(admin_id) + 1 FROM administrators), 1);\n    END IF;\nEND'
sql_modes=1098907648
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_unicode_ci'
db_cl_names='utf8mb4_general_ci'
created=1723134158516749
