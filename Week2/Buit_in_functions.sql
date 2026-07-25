USE gram_panchayat_db;
SHOW TABLES;

SELECT UPPER(full_name) FROM Citizen;  
 
 SELECT LOWER(village_name) FROM Citizen;
 
 SELECT full_name,LENGTH(full_name) AS Name_Length FROM Citizen;
 
 SELECT reference_number,SUBSTRING(reference_number,1,4) AS First_Four_Characters FROM certificate_application;
 
 SELECT CONCAT(full_name , ' - ',village_name) AS Details FROM Citizen; 
 
 SELECT REPLACE(certificate_name,"Certificate","Cert") AS Certificate_Name FROM certificate_type;
 
 -- Remove leading or trailing spaces from certificate names
 SELECT TRIM(certificate_name) AS Certificate_Name FROM certificate_type;
 
 SELECT full_name,SUBSTRING_INDEX(full_name,' ',1) AS First_Name FROM Citizen;
 
 SELECT CONCAT('Citizen :',full_name ,'  \n  Village :',village_name) FROM Citizen;
 
 SELECT * FROM certificate_application WHERE reference_number LIKE 'GP2026%';
 
     -- Built-in Numeric Functions
 
 SELECT application_fee,ROUND(application_fee) AS Rounded_fee FROM certificate_type;
 
 SELECT * FROM certificate_type WHERE processing_days LIKE 10;
 
 SELECT processing_days,ABS(processing_days - 10)AS difference FROM certificate_type;
 
 SELECT processing_days,POWER(processing_days,2) AS Square FROM certificate_type;
 
 SELECT processing_days,MOD(processing_days,3) AS Remainder FROM certificate_type;
 
 SELECT application_fee,ROUND(application_fee,1) AS Rounded_Fee FROM certificate_type;
 
 SELECT application_fee,CEIL(application_fee) AS Ceiling_Value ,FLOOR(application_fee) AS Floor_Value FROM certificate_type;
 
 SELECT FLOOR(1 + RAND() * 100) AS Random_Number;
 
 SELECT processing_days,SQRT(processing_days) AS Square_Root FROM certificate_type;
 
 SELECT processing_days,processing_days*2 AS Double_Processing_Days FROM certificate_type;
 
   -- DATE FUNCTIONS
SELECT CURDATE() AS Today_Date;

SELECT NOW() AS Current_date_time;

SELECT application_date,YEAR(application_date) AS Year FROM certificate_application;

SELECT application_date,MONTH(application_date) AS Month FROM certificate_application;

SELECT application_date,DAY(application_date) AS Day FROM certificate_application;

SELECT application_date,processing_days,DATE_ADD(application_date,INTERVAL processing_days DAY) AS Expected_Issed_Date FROM certificate_application,certificate_type;

SELECT application_date,DATE_ADD(application_date, INTERVAL 30 DAY) AS After_30_Days FROM certificate_application;

DESCRIBE certificate_application;

SELECT application_date,DATE_SUB(application_date,INTERVAL 7 DAY) AS Before_7_Days FROM certificate_application;


SELECT application_date,DATEDIFF(CURDATE(),application_date) AS Days_Difference FROM certificate_application;

SELECT * FROM certificate_application WHERE YEAR(application_date) = YEAR(CURDATE());

-- CONVERSION FUNCTIONS
SELECT application_fee,CAST(application_fee AS SIGNED) AS Fee_Integer  FROM certificate_type;

SELECT processing_days,CAST(processing_days AS CHAR) AS Processing_Days_char FROM certificate_type;

SELECT application_date,CAST(application_date AS DATETIME) AS Application_Date_Time FROM certificate_application;

SELECT processing_days,CAST(processing_days AS DECIMAL(10,2)) AS Processing_Days_Decimal FROM certificate_type;

SELECT application_fee,CAST(application_fee AS CHAR) AS Fee_As_Char FROM certificate_type;

SELECT application_fee,CAST(application_fee AS DECIMAL(10,2))*2  AS Double_Fee FROM Certificate_type;
