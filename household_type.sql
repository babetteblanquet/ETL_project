CREATE TABLE households_type (
	stat_date DATE NOT NULL,
	sa2_code VARCHAR(9) NOT NULL,
	sa2_name VARCHAR(50) NOT NULL,
	Couple_family_with_children INTEGER NOT NULL,
	Couple_family_without_children INTEGER NOT NULL,
	One_parent_family INTEGER NOT NULL,
	Other_family INTEGER NOT NULL,
	Group_household INTEGER NOT NULL,
	Lone_person INTEGER NOT NULL,
	All_Household_Types INTEGER NOT NULL,
	PRIMARY KEY (sa2_code, stat_date)
);

