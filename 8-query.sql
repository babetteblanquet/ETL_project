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