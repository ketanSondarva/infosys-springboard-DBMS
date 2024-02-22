-- Active: 1708238809852@@127.0.0.1@3306@infosyssb

-- SQL functions are built in modules provided by a database. You can use them in data manipulation statements to perform calculations on data.



--- NUMERIC Function:

-- ceil, floor, abs
SELECT City, MinTemp, CEIL(MinTemp) AS "Ceiling",
FLOOR(MinTemp) AS "Floor", ABS(MinTemp) as "Absolute"  FROM Weather;

-- round:
SELECT City, MinTemp, ROUND(MinTemp) as "Round", ROUND(MinTemp,1) as "RoundTo1Digit" FROM Weather;


--- CHARACTER Function:

-- length, upper and lower
SELECT City, LENGTH(City) "LENGTH",  LOWER(City) "LOWERCASE", UPPER(City) "UPPERCASE" FROM Weather;

-- concating the string data

SELECT City, Country, CONCAT(City, Country) "CONCAT", 
City || Country "ConcatByOperator", CONCAT(CONCAT(City, ', '), Country) "NestedConcat" FROM Weather;

-- substring:
SELECT City, SUBSTR(City,1,4) FIRST4, SUBSTR(City,2,10) TEN_FROM_2, SUBSTR(City,3) ALL_FROM_3, 
SUBSTR(City,7, 2) TWO_FROM_7 FROM Weather;

-- substring with date:
SELECT RecordDate, SUBSTR(RecordDate,1,2) "DAY", SUBSTR(RecordDate,4,3) "MONTH", 
SUBSTR(RecordDate,8) "YEAR" FROM Weather;

-- conversion function:

-- convert number or a date to a string. use this function for formatting dates and numbers:

SELECT MinTemp, TO_CHAR(MinTemp) DEF_FORMAT, TO_CHAR(MinTemp, '999.99') "FIXED_DIGITS",
TO_CHAR(MinTemp, '9,9.99') "COMMA" FROM Weather;

-- Use TO_NUMBER to convert a number string into a number:
SELECT '1000.98' "ORIG_NOFORMAT", TO_NUMBER('1000.98') "CONV_NOFORMAT", '1,000.98' "ORIG_FORMAT", 
TO_NUMBER('1,000.98', '9,999.99') "CONV_FORMAT" FROM DUAL;

-- You can use TO_CHAR with dates to extract date parts like Date, Month, Year:
SELECT RecordDate, TO_CHAR(RecordDate, 'MON') "MONTH", TO_CHAR(RecordDate, 'Month') "FULL_MONTH", TO_CHAR(RecordDate, 'Dy') "DAY", 
TO_CHAR(RecordDate, 'Day') "FULL_DAY" FROM Weather;

-- TO_CHAR can also be used to format dates in your desired format:
SELECT TO_CHAR(RecordDate) DEF_FORMAT, TO_CHAR(RecordDate, 'DD/MM/CCYY') INDIAN, TO_CHAR(RecordDate, 'MM/DD/YY') AMERICAN FROM Weather;

-- NOTE: TO_DATE() wont work in mysql
-- Use TO_DATE(wont work for mysql) to convert a formatted date string to a date:
SELECT '2014-01-01' DATE_STRING, TO_DATE('2014-01-01') CONV_NOFORMAT, TO_DATE('2014-01-01', 'DD-Mon-YYYY') CONV_FORMAT FROM DUAL

-- Format string must be used with TO_DATE if date string is not in default Oracle format:
SELECT 'Jan-01-2014' DATE_STRING, TO_DATE('Jan-01-2014', 'Mon-DD-YYYY') CONV_FORMAT FROM DUAL

-- date and time in mysql:

SELECT STR_TO_DATE('2024-02-21', '%Y-%m-%d');
SELECT STR_TO_DATE('22-02-2024', '%d-%m-%Y');
SELECT CURDATE();
SELECT DATE(NOW());
SELECT TIMESTAMP(NOW());
SELECT TIME(NOW());
SELECT TIMESTAMPADD(MINUTE, 1, '2003-01-02');
SELECT TIMESTAMPDIFF(DAY,'2003-02-01','2003-05-01');
SELECT TIMESTAMPDIFF(MONTH,'2003-02-01','2003-05-01');


--- AGGREGATE Function:

-- min, max and sum function:
SELECT MIN(Salary), MAX(Salary), SUM(Salary) FROM Employee

SELECT * FROM Employee

DESC Employee

-- count NOTE: wont count the null values i.e. check the bonus and manager column
SELECT COUNT(ID) COUNT_ID, COUNT(*) COUNT_STAR, COUNT(Bonus) COUNT_BONUS, COUNT(MANAGER) TOTAL_MGR FROM Employee


--- Miscelleneous but important function:

-- NVL: Substitutes value1 by value2 if value1 is NULL. The data type of value1 and value2 must be same.

SELECT NVL(BONUS, 0.0) FROM Employee; -- this function not available for mysql, alternative: COALESCE

SELECT COALESCE(BONUS, 0.0) FROM Employee;
SELECT COALESCE(MANAGER, -1) FROM Employee; -- the -1 denotes id not available yet

SELECT USER FROM DUAL; -- wont work for mysql

-- in mysql: 
SELECT USER();

