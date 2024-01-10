--Creating table name as Ads

CREATE TABLE Ads (
    Country VARCHAR(255),
	Audience  VARCHAR(255),
	Campaign VARCHAR(255),
	Clicks int,
	Cost float,
	Impressions int,
	Fees float
	);

--Importing csv file data into Ads table

BULK INSERT Project1
FROM 'D:\A\SQL\Projects\1\sqlsample1.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Skip header if present
    TABLOCK
);
----------------------------
--Creating table name as Agent

CREATE TABLE Agent(
    Country VARCHAR(255),
	CountryAgent  VARCHAR(255),
	);
	
--Importing csv file data into Agent table

 BULK INSERT Agent
FROM 'D:\A\SQL\Projects\1\Agent.csv'
WITH (
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Skip header if present
   TABLOCK
);

select * from Agent;

select * from Ads;

---------------------------------------------------------------------------------------------------
--Q1. Find the total cost for the only google campaign for all countries.
select Campaign, sum(Cost) as Total_Cost
From Ads
Where Campaign= 'Google'
Group by Campaign;


--Q2. Find the cpc(cost per click) value per audience.
SELECT audience,  SUM(cost)/SUM(clicks) as cpc
FROM Ads
GROUP BY audience;

--Q3. Display the cities with total clicks greater than 500.
SELECT country, sum(clicks) as Total_Clicks
FROM Ads
GROUP BY country
HAVING sum(clicks) > 500;


--Q4. Sort by country.
SELECT country, sum(clicks) as Total_Clicks
FROM Ads
GROUP BY country
HAVING sum(clicks) > 500
ORDER BY country;


--Q5. Create a new column cost new. Give it a value abovethreshold if cost > 20, then belowthreold.
SELECT *, CASE WHEN cost > 20 then 'AboveThrehold' else 'BelowThreshold' end as NewCost
FROM Ads;


--Q6. Display the agents in tota fees in desc order.
SELECT a.CountryAgent as Agent, sum(p.fees) AS TotalFees
FROM Agent a
inner join Ads p
on p.country = a.Country
GROUP BY CountryAgent
ORDER BY 2 DESC;


--Q7. Display the country and total impressions value only for fb campaigns woth total impressions > 1000 and sort them by country.
SELECT country, SUM(impressions) as TotalImpressions 
FROM Ads
WHERE campaign = 'Facebook'
GROUP BY country
HAVING SUM(impressions) > 10000
ORDER BY 1;

