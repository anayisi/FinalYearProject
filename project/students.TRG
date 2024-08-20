TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER before_insert_students\nBEFORE INSERT ON students\nFOR EACH ROW\nBEGIN\n    IF NEW.student_id IS NULL THEN\n        SET NEW.student_id = IFNULL((SELECT MAX(student_id) + 1 FROM students), 1);\n    END IF;\nEND'
sql_modes=1098907648
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_unicode_ci'
db_cl_names='utf8mb4_general_ci'
created=1723134158289397
