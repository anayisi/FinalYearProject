TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER before_insert_lecturers\nBEFORE INSERT ON lecturers\nFOR EACH ROW\nBEGIN\n    IF NEW.lecturer_id IS NULL THEN\n        SET NEW.lecturer_id = IFNULL((SELECT MAX(lecturer_id) + 1 FROM lecturers), 1);\n    END IF;\nEND'
sql_modes=1098907648
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_unicode_ci'
db_cl_names='utf8mb4_general_ci'
created=1723134158419662
