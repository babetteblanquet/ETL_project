# The Victorian population and the projections of households until 2036. #

**Team Members:**
1.	Joanna Gu
2.	Ian Lim
3.	Nelson Javier Garcia
4.	Babette Blanquet

## 1.	Project overview: ##
In this ETL project, our goal is to build a database to understand the correlation between current population growth and projections of number of households in Victoria.

Our dataset will provide data at the Statistical Area 2 (SA2) level which is equivalent to a suburb. For reference, there are 462 suburbs or SA2 in Victoria.

With the new dataset, we will be able to create new queries to answer questions such as:
-	What’s the current population growth in each suburb (SA2)?
-	Is there a correlation between population growth and population density in each SA2?
-	Is there a correlation between household projections and current population growth?
-	Is there a correlation between household projections and the type of migration?
-	Which suburbs or SA2 will be with the highest population density in 2036? 
-	What Victoria will look like in terms of population density in 2036?

This analysis will be useful to forecast the needs of schools, aged care facilities, amenities, number and types of dwellings to service each area at Sa2 level but also SA3 and SA4 which are greater areas.

## 2.	Extract the data sources ## 

**Dataset 1:**

Regional Population Growth 2018-2019
Source: Australia Bureau of Statistics

This dataset provides the data outlined below for Statistical Areas from Level 2 to Level 4 (SA2, SA3, SA4), Greater Capital City Statistical Areas (GCCSA) and Victoria:

o	The estimated population in 2018
o	The estimated population in 2019
o	The components of population change
  -	The natural migration
  - 	The internal migration
  -	The overseas migration
o	The size of each area (km2)
o	The population density in 2019

This dataset is in Excel format.

Extract method: this dataset has been downloaded from its source and the Table 2 saved as CSV.
https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/3218.02018-19?OpenDocument


**Dataset 2:**

Victoria in Future 2019 (VIF2019) Population and Household Projections – Table “Household Types”
Source: Planning Victoria

This dataset provides the number of households by household type for Statistical Areas from Level 2 to Level 4 (SA2, SA3, SA4), Greater Capital City Statistical Areas (GCCSA) and Victoria:
 - 	The estimated number of household types in 2016, 2021, 2026, 2031, 2036
With the breakdown below:
  -	Couple family with children	
  -	Couple family without children	
  - One-parent family	
  -	Other family	
  - Group household	
  - Lone person
  - All Household Types

Extract method: this dataset has been downloaded from its source and the relevant table saved as CSV.
https://www.planning.vic.gov.au/land-use-and-population-research/victoria-in-future

## 3.	Transform: the cleaning, checks and Exploratory Data Analysis process ##

**Dataset 1: The Regional Population Growth 2018-2019 from ABS**

The transformations have been applied in a Jupyter Notebook named: (“ABS_population_growth18-19_Transformation.ipynb”)

*Basic transformations applied:*

-	Setting the row containing the column names as the new header
-	Renaming some columns with iloc as 6 columns appeared under the same name ‘no.’
-	Removing ‘junk’ rows at the top and bottom of the table using the iloc method
-	Selecting the columns needed for our database

*Checking the quality of the data:*

-	Dropping any NULL value and checking the count of rows
-	Checking the type of data
-	As they are all string/object, we converted the relevant columns to integer and float

*Exploratory Analysis:*

-	Checking the min and max values with the describe() method
-	The min value being at 0 for the population 2018/19 and the population density, we will sort the dataframe to understand the reasons some suburbs might have no population.
-	We sorted the dataframe to identify the 10 suburbs with the lowest population in 2019. The suburbs are for example Essendon Airport or Wilsons Promontory. It makes sense people work or walk there but not many live in these suburbs.
-	We looked at the correlation between population 2019 and the population density 2019 to ‘map’ all suburbs. 
![Population_vs_population_density](https://github.com/babetteblanquet/images/blob/master/ETL-1.png)

-	We can identify a few outliers – so we checked to see if the suburbs with the highest density were relevant. All suburbs with a high population density are the closest to Melbourne CBD and are relevant.

**Dataset 2: The Regional Population Growth 2018-2019 from ABS**

The transformations have been applied in a Jupyter Notebook named: (“Household_types_Transformation.ipynb”)

*Basic transformations applied:*

-	Setting the row containing the column names as the new header
-	Removing ‘junk’ rows at the top and bottom of the table using the iloc method
-	A breakdown of the dataset of 45 columns into five smaller datasets - each will contain the households projected at different years: 2016, 2021, 2026, 2031, 2036
-	A new column Year/Date has been added to each dataset
-	Then a master file has been created by concatenating the five small datasets. 
-	The master file contains 2310 rows - which includes the count of households in 462 suburbs for five different years. 

*Checking the quality of the data:*

-	Checking the type of data: most of the data is in string format although seven columns should be integers to be able to perform aggregations.
-	Removing commas from numbers (e.g. 1,675 to 1675) to be able to convert them as integers.
-	Dropping Null values
-	Dropping eventual duplicates – it happens the dataset had no null value or duplicate

*Exploratory Analysis:*

-	Checking the min and max values with the describe() method
-	The min value being at 0 we will group and sort the dataframe to understand the reasons some suburbs might have 0 households.
-	There are six suburbs at 0 households, but they are either national parks or airports. Therefore, the data is relevant.
-	We compared the number of total households in 2016 versus the projections in 2036 to check if the data is relevant with a linear regression model.

![Count of total households in 2016 vs 2036](https://github.com/babetteblanquet/images/blob/master/ETL-2.png)

-	The linear regression shows most suburbs are expected to grow by 1.5 over 20 years but quite a few suburbs will grow at much higher rate (outliers).
-	To verify the quality of the data we wanted to identify these suburbs seen as outliers 
-	We calculated the growth rate between 2016 and 2036 and sorted the data to identify the suburbs with the highest growth.
-	We can identify the main suburbs Planning Victoria is expected to develop intensively over the next 20 years – such as Port Melbourne Industrial Flemington Racecourse and Rockbank- Mount Cottrell. 

**Conclusion:** the quality of the data is good and can be loaded in the database.

The master file has been saved as csv named “master_households_types.csv”

## 4.	LOAD - Data storage ##

We have chosen to load the data and store them in relational database as the data is more structured and a relationship between the datasets can be established.

We have identified SA2 (Statistical Area 2) code as the foreign key to join the datasets.  We can then perform queries joining the data from the two tables.

Please see Entity Relationship Diagram (ERD) below depicting the relationship between the two tables from the datasets.
![Count of total households in 2016 vs 2036](https://github.com/babetteblanquet/images/blob/master/ETL-3.png)

**Queries used after loading to database:**

Query all rows in each table: Select * from households_type;
-	Query household growth for a sa2 area for each forecast period: 
o	Select stat_date, sa2_code, sa2_name, couple_family_with_children from households_type where sa2_code = '210051445';


We can also perform query joining information from the 2 tables such as the one below:

SELECT 
	p.sa3_code,
	p.sa3_name,
	p.sa2_code, 
	p.sa2_name, 
	p.area_size,
	p.population_density_2019,
	h.stat_date, 
	h.couple_family_with_children,
	h.couple_family_without_children
FROM population_growth p
INNER JOIN households_type AS h ON
	p.sa2_code = h.sa2_code
WHERE h.stat_date = '2021-06-30' AND p.sa3_code = '20501';


-----------------------------------------------

Here is how the repository is organised:

0- Original XL files dowsloaded from sources
1- Proposal of the project
2- CSV (original files converted to CSV)
3- The notebook for the Transformation of the ABS Population data named: "3-ABS_population_growth18-19_Transformation"
4- The notebook for the Transformation of the Household types from Planning Victoria named: "4-Household_types_Transformation"
5-The final report named "5-ETL Report-Team_5-Final"
6-ERD image
7-Schema.sql - the schema to create the SQL database
8-query.sql is an example of query we can perform on the joined tables.


