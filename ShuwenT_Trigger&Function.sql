use synthea;
show tables;

##Create fake table within synthea for trigger and function practice
CREATE TABLE ShuwenT_BloodSugarData (id INT AUTO_INCREMENT PRIMARY KEY, patient_ID INT NOT NULL, last_name VARCHAR(50) NOT NULL, Fasting INT NOT NULL, HbA1c INT NOT NULL);
INSERT INTO ShuwenT_BloodSugarData (patient_ID, last_name, Fasting, HbA1c) VALUES (123456, 'Tan', 80, 5.0), (234567, 'Yuan', 90, 5.5), (345678, 'Jeung', 85, 5.3), (456789, 'Zhong', 75, 4.7), (567890, 'Chen', 77, 5.3), (512521, 'Mei', 80, 5.0),(124215, 'Kim', 88, 5.3);

##Trigger on Fasting Blood Glucose values 
DELIMITER $$
CREATE TRIGGER Fasting BEFORE INSERT ON ShuwenT_BloodSugarData
FOR EACH ROW 
BEGIN
    IF NEW.Fasting >= 100 THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ERROR: Fasting Blood Glucose must be below 100 mg/dl!';
    END IF; 
END; $$

##Function
DELIMITER $$
CREATE FUNCTION TestCost(cost DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE LabCost VARCHAR(20);
IF cost > 100 THEN
SET LabCost = ‘expensive’;

ELSEIF (cost >= 25 AND
credit <= 75) THEN
SET LabCost = 'standard';

ELSEIF cost < 25 THEN
SET LabCost = 'cheap';
END IF;
-- return the lab cost category
RETURN (LabCost);
END$$
DELIMITER ;
