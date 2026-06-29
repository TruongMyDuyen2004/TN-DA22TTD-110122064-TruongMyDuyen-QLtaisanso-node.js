SET NAMES utf8mb4;

-- Bước 1: Gộp KKTCN (id=11) vào CET (id=4)
UPDATE devices SET department_id = 4 WHERE department_id = 11;
UPDATE users SET department_id = 4 WHERE department_id = 11;
UPDATE asset_transfers SET from_department_id = 4 WHERE from_department_id = 11;
UPDATE asset_transfers SET to_department_id = 4 WHERE to_department_id = 11;
UPDATE device_lifecycle SET from_department_id = 4 WHERE from_department_id = 11;
UPDATE device_lifecycle SET to_department_id = 4 WHERE to_department_id = 11;
DELETE FROM departments WHERE id = 11;

-- Bước 2: Gộp PKT2 (id=13) vào PDT (id=9)
UPDATE devices SET department_id = 9 WHERE department_id = 13;
UPDATE users SET department_id = 9 WHERE department_id = 13;
UPDATE asset_transfers SET from_department_id = 9 WHERE from_department_id = 13;
UPDATE asset_transfers SET to_department_id = 9 WHERE to_department_id = 13;
UPDATE device_lifecycle SET from_department_id = 9 WHERE from_department_id = 13;
UPDATE device_lifecycle SET to_department_id = 9 WHERE to_department_id = 13;
DELETE FROM departments WHERE id = 13;

-- Bước 3: Xóa dữ liệu rác (id=15)
DELETE FROM departments WHERE id = 15;
