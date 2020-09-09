ETL Group project: The Victorian population and the projections of households until 2036.

**Team Members:**
1.	Joanna Gu
2.	Ian Lim
3.	Nelson Javier Garcia
4.	Babette Blanquet

**1.	Project overview:**
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

**2.	Extract the data sources**

•	Dataset 1:

Regional Population Growth 2018-2019
Source: Australia Bureau of Statistics

This dataset provides the data outlined below for Statistical Areas from Level 2 to Level 4 (SA2, SA3, SA4), Greater Capital City Statistical Areas (GCCSA) and Victoria:

o	The estimated population in 2018
o	The estimated population in 2019
o	The components of population change
  -	The natural migration
  - The internal migration
  - The overseas migration
o	The size of each area (km2)
o	The population density in 2019

This dataset is in Excel format.

Extract method: this dataset has been downloaded from its source and the Table 2 saved as CSV.
https://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/3218.02018-19?OpenDocument


•	Dataset 2:

Victoria in Future 2019 (VIF2019) Population and Household Projections – Table “Household Types”
Source: Planning Victoria

This dataset provides the number of households by household type for Statistical Areas from Level 2 to Level 4 (SA2, SA3, SA4), Greater Capital City Statistical Areas (GCCSA) and Victoria:
o	The estimated number of household types in 2016, 2021, 2026, 2031, 2036
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

**3.	Transform: the cleaning, checks and Exploratory Data Analysis process**

Dataset 1: The Regional Population Growth 2018-2019 from ABS

The transformations have been applied in a Jupyter Notebook named: (“ABS_population_growth18-19_Transformation.ipynb”)

Basic transformations applied:

-	Setting the row containing the column names as the new header
-	Renaming some columns with iloc as 6 columns appeared under the same name ‘no.’
-	Removing ‘junk’ rows at the top and bottom of the table using the iloc method
-	Selecting the columns needed for our database

Checking the quality of the data:

-	Dropping any NULL value and checking the count of rows
-	Checking the type of data
-	As they are all string/object, we converted the relevant columns to integer and float

Exploratory Analysis:

-	Checking the min and max values with the describe() method
-	The min value being at 0 for the population 2018/19 and the population density, we will sort the dataframe to understand the reasons some suburbs might have no population.
-	We sorted the dataframe to identify the 10 suburbs with the lowest population in 2019. The suburbs are for example Essendon Airport or Wilsons Promontory. It makes sense people work or walk there but not many live in these suburbs.
-	We looked at the correlation between population 2019 and the population density 2019 to ‘map’ all suburbs. 
![Population_vs_population_density](/images/ETL1.png)
Format: ![Alt Text](url)

-	We can identify a few outliers – so we checked to see if the suburbs with the highest density were relevant. All suburbs with a high population density are the closest to Melbourne CBD and are relevant.

-----------------------------------------------

In this repository you will find the ETL project for Team 5:

The Victorian population and the projections of households until 2036


The folders are organised as per below:

0- Original XL files dowsloaded from sources

1- Proposal of the project

2- CSV (original files converted to CSV)

3- The notebook for the Transformation of the ABS Population data named: "3-ABS_population_growth18-19_Transformation"

4- The notebook for the Transformation of the Household types from Planning Victoria named: "4-Household_types_Transformation"

5-The final report named "5-ETL Report-Team_5-Final"

6-ERD image

7-Schema.sql - the schema to create the SQL database

8-query.sql is an example of query we can perform on the joined tables.


