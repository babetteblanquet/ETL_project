CREATE TABLE households_type (
	id SERIAL PRIMARY KEY,
	stat_date DATE NOT NULL,
	sa2_code VARCHAR(9) NOT NULL,
	sa2_name VARCHAR(50) NOT NULL,
	couple_family_with_children INTEGER NOT NULL,
	couple_family_without_children INTEGER NOT NULL,
	one_parent_family INTEGER NOT NULL,
	other_family INTEGER NOT NULL,
	group_household INTEGER NOT NULL,
	lone_person INTEGER NOT NULL,
	all_household_types INTEGER NOT NULL,
	FOREIGN KEY (sa2_code) REFERENCES population_growth(sa2_code)	
);


CREATE TABLE population_growth (
	sa2_code VARCHAR(9) PRIMARY KEY,
	sa2_name VARCHAR(50) NOT NULL,
	sa3_code VARCHAR(5) NOT NULL,
	sa3_name VARCHAR(50) NOT NULL,
	sa4_code  VARCHAR(3) NOT NULL,
	sa4_name VARCHAR(50) NOT NULL,
	population_2018 INTEGER NOT NULL,
	population_2019 INTEGER NOT NULL,
	natural_increase INTEGER NOT NULL,
	net_internal_migration INTEGER NOT NULL,
	net_overseas_migration INTEGER NOT NULL,
	area_size NUMERIC NOT NULL,
	population_density_2019 NUMERIC NOT NULL
);
