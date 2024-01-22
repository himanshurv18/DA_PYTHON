/****** Script for SelectTopNRows command from SSMS  ******/
/* SELECT *
  FROM [NY Housing Market].[dbo].[Cleaned_Data$] */


  /* Price Analysis */
-- 1.What is the average price of houses in each state?

SELECT 
    CASE 
        WHEN UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1)) IN ('NEW YORK', 'NYC', 'NY') THEN 'NEW YORK'
        ELSE UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1))
    END AS STATE,
    round(AVG(PRICE),2) AS AVERAGE_PRICE
FROM 
    [NY Housing Market].[dbo].[Cleaned_Data$]  -- Replace with your actual table name
GROUP BY 
    CASE 
        WHEN UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1)) IN ('NEW YORK', 'NYC', 'NY') THEN 'NEW YORK'
        ELSE UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1))
    END;

	/*
	STATE	AVERAGE_PRICE
ARVERNE	961999.83
ASTORIA	876242.65
BAYSIDE	877033.49
BEDFORD STUYVESANT	1307666.33
BEECHHURST	721455.2
BELLE HARBOR	999000
BELLEROSE	739717
BRIARWOOD	603472
BRIGHTON BEACH	250000
BRONX	761690.3
BRONX NY	150000
BROOKLYN	1440970.07
BROOKLYN HEIGHTS	3000000
BROWNVILLE	544994.67
CAMBRIA HEIGHTS	626483.17
CANARSIE	2999950
COLLEGE POINT	1126790.32
CORONA	817019.82
CROWN HEIGHTS	684399.8
DITMAS PARK	1250000
DOUGLASTON	744111.11
EAST ELMHURST	906460.11
EAST FLATBUSH	819000
ELMHURST	654038.74
FAR ROCKAWAY	710590.86
FLORAL PARK	642426.2
FLUSHING	824832.49
FOREST HILLS	560707.32
FRESH MEADOWS	1091538.46
GLEN OAKS	727380
GLENDALE	931166.67
HOLLIS	972253.45
HOWARD BEACH	672561.18
JACKSON HEIGHTS	586740.07
JAMAICA	924012.5
KENSINGTON	386333.33
KEW GARDEN HILLS	399000
KEW GARDENS	500514.74
KEW GARDENS HILLS	302666.67
LITTLE NECK	826461.79
LONG ISLAND CITY	1134210.89
MALBA	2966296
MANHATTAN	3374570.26
MASPETH	998367.38
MIDDLE VILLAGE	936559.86
NEW HYDE PARK	325000
NEW YORK	7146200.49
NEW YORK CITY	969000
OLD MILL BASIN	428333
OZONE PARK	573818.09
PROSPECT LEFFERTS GARDENS	650000
QUEENS	1079398.46
QUEENS VILLAGE	567618
REGO PARK	488957.17
RICHMOND HILL	885876.22
RICHMOND HILL SOUTH	674000
RIDGEWOOD	1524617.18
ROCKAWAY PARK	701916.58
ROOSEVELT ISLAND	595000
ROSEDALE	558971.29
SAINT ALBANS	654161.06
SOUTH OZONE PARK	741698.24
SPRINGFIELD GARDENS	1189218.29
STATEN ISLAND	916367.75
STUYVESANT HEIGHTS	2380000
SUNNYSIDE	739666.67
WHITESTONE	1444166
WOODHAVEN	740523.53
WOODSIDE	821658.94
	*/

--	2. Identify the top 5 most expensive houses address in the dataset.

select TOP 5 ADDRESS, PRICE
from [NY Housing Market].[dbo].[Cleaned_Data$]
order by PRICE DESC;


--  Property Size Analysis:
-- 3. Calculate the correlation between property square footage and house prices.

/*
r= n∑(xy)−∑x∑y​ /
(n∑x 2 −(∑x) 2)(n∑y 2−(∑y) 2)​

*/

SELECT
	round(    (COUNT(*) * SUM(PROPERTYSQFT * PRICE) - SUM(PROPERTYSQFT) * SUM(PRICE)) /
    SQRT(
	(COUNT(*) * SUM(PROPERTYSQFT * PROPERTYSQFT) - POWER(SUM(PROPERTYSQFT), 2)) * 
    (COUNT(*) * SUM(PRICE * PRICE) - POWER(SUM(PRICE), 2))
		 ),2) AS correlation
FROM [NY Housing Market].[dbo].[Cleaned_Data$];


/*
What is the average property square footage for houses with more than 3 bedrooms?
*/

select
round(AVG(PROPERTYSQFT),3) as Average_Property_SQFT
FROM [NY Housing Market].[dbo].[Cleaned_Data$]
where BEDS > 3;


/*
Identify the top 3 localities with the highest average house prices.
*/

select  Top 3 LOCALITY, Avg(Price) as Average_Price
from [NY Housing Market].[dbo].[Cleaned_Data$]
Group by LOCALITY
order by Average_Price desc


/*
Find the number of houses in each state.
*/
SELECT 
    CASE 
        WHEN UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1)) IN ('NEW YORK', 'NYC', 'NY') THEN 'NEW YORK'
        ELSE UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1))
    END AS STATE,
    COUNT(TYPE) AS Number_of_House
FROM 
    [NY Housing Market].[dbo].[Cleaned_Data$]  -- Replace with your actual table name
GROUP BY 
    CASE 
        WHEN UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1)) IN ('NEW YORK', 'NYC', 'NY') THEN 'NEW YORK'
        ELSE UPPER(LEFT(STATE, CHARINDEX(',', STATE) - 1))
    END;


	/*
	Identify the house with the highest number of bedrooms and bathrooms.
	*/

SELECT Top 1 TYPE,	PRICE,	BEDS,	BATH,	PROPERTYSQFT,	ADDRESS,	STATE
FROM [NY Housing Market].[dbo].[Cleaned_Data$]
ORDER BY BEDS DESC, BATH DESC;


/*
List the top 3 brokers with the highest average house prices.
*/
SELECT TOP 3 BROKERTITLE, AVG(Price) as Average_Price
FROM [NY Housing Market].[dbo].[Cleaned_Data$]
GROUP BY BROKERTITLE
ORDER BY Average_Price DESC;

