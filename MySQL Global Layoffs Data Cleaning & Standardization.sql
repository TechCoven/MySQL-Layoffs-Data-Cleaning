-- MySQL Global Layoffs Data Cleaning & Standardization

SELECT *
FROM layoffs;

-- CREATING A STAGING TABLE

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT *
FROM layoff_staging;

INSERT INTO layoff_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS Row_Num
FROM layoff_staging;


WITH duplicate_cte AS
(SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS Row_Num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE Row_Num > 1;

SELECT *
FROM layoff_staging
WHERE company = 'Casper';


CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS Row_Num
FROM layoff_staging;

SELECT *
FROM layoff_staging2
WHERE Row_num > 1;

DELETE
FROM layoff_staging2
WHERE Row_num > 1;

-- STANDARDIZING DATA

SELECT distinct TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company =  TRIM(company);

SELECT distinct industry
FROM layoff_staging2
ORDER BY 1;

SELECT *
FROM layoff_staging2
WHERE INDUSTRY LIKE 'CRYPTO%';

UPDATE layoff_staging2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';


SELECT distinct location
FROM layoff_staging2
ORDER BY 1;

SELECT distinct country
FROM layoff_staging2
ORDER BY 1;



SELECT distinct country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;


UPDATE layoff_staging2
SET COUNTRY = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET date = STR_TO_DATE(`date`, '%m/%d/%Y');


SELECT *
FROM layoff_staging2;


ALTER TABLE layoff_staging2
MODIFY COLUMN `date` date;


SELECT *
FROM layoff_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

DELETE
FROM layoff_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;



SELECT *
FROM layoff_staging2
WHERE industry is NULL
OR industry = '';

SELECT *
FROM layoff_staging2
WHERE company = 'Airbnb';


UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoff_staging2 AS t1
JOIN layoff_staging2 AS t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;    

UPDATE layoff_staging2 AS t1
JOIN layoff_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL; 


SELECT *
FROM layoff_staging2;


ALTER TABLE layoff_staging2
DROP COLUMN Row_num;







