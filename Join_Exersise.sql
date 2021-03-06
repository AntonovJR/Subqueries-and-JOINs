-- 1
SELECT e.`employee_id`, e.`job_title`, e.`address_id`, t.`address_text`
FROM `employees` AS e
JOIN `addresses` AS t
USING (`address_id`)
ORDER BY e.`address_id` LIMIT 5;

-- 2
SELECT e.`first_name`, e.`last_name`, t.`name` AS 'town', a.`address_text`
FROM `employees` AS e
JOIN `addresses` AS a ON a.`address_id` = e.`address_id`
JOIN `towns` AS t ON t.`town_id` = a.`town_id`
ORDER BY e.`first_name`, e.`last_name` LIMIT 5;

-- 3
SELECT e.`employee_id`, e.`first_name`, e.`last_name`, d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments`AS d
USING(`department_id`)
WHERE d.`name` LIKE 'Sales'
ORDER BY `employee_id` DESC;

-- 4
SELECT e.`employee_id`, e.`first_name`, e.`salary`, d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments`AS d
USING(`department_id`)
WHERE e.`salary`> 15000
ORDER BY `department_id` DESC LIMIT 5;

-- 5
SELECT e.`employee_id`, e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep
ON ep.`employee_id` = e.`employee_id`
WHERE ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC LIMIT 3;

-- 6
SELECT e.`first_name`, e.`last_name`, e.`hire_date`, d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments`AS d
USING(`department_id`)
WHERE d.`name` IN('Sales','Finance') AND e.`hire_date`>1999/1/1
ORDER BY `hire_date` ASC;

-- 7
SELECT e.`employee_id`, e.`first_name`, p.`name` AS 'project_name' FROM `employees` AS e
JOIN `employees_projects` AS ep 
ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p 
ON ep.`project_id` = p.`project_id`
WHERE DATE(p.`start_date`) > '2002-08-13' AND DATE( p.`end_date`) IS NULL
ORDER BY e.`first_name` ASC , `project_name` ASC LIMIT 5;

-- 8
SELECT e.`employee_id`, e.`first_name`, p.`name` AS 'project_name' FROM `employees` AS e
JOIN `employees_projects` AS ep 
ON e.`employee_id` = ep.`employee_id`
LEFT OUTER JOIN `projects` AS p 
ON ep.`project_id` = p.`project_id`
AND YEAR(p.`start_date`) <  2005
WHERE e.`employee_id` = 24
ORDER BY `project_name`;

-- 9
SELECT e.`employee_id`, e.`first_name`, m.`employee_id` AS 'manager_id', m.`first_name` AS 'manager_name' 
FROM `employees` AS e
JOIN `employees` AS m
ON m.`employee_id` = e.`manager_id`
WHERE e.`manager_id` IN (3,7)
ORDER BY e.`first_name`;

-- 10
SELECT e.`employee_id`, CONCAT(e.`first_name`, ' ', e.`last_name`) AS 'employee_name',
CONCAT(m.`first_name`, ' ', m.`last_name`) AS 'manager_name', d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `employees` AS m
ON m.`employee_id` = e.`manager_id`
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
ORDER BY e.`employee_id` LIMIT 5;

-- 11
SELECT AVG(`salary`) AS e 
FROM `employees` 
GROUP BY `department_id`
ORDER BY e LIMIT 1;

-- 12
 SELECT mc.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
 FROM mountains_countries AS `mc` 
 JOIN `mountains` AS m 
 ON mc.`mountain_id` = m.`id`
 JOIN `peaks` AS p ON p.`mountain_id` = m.`id`
 WHERE mc.`country_code` = 'BG' AND p.`elevation` > 2835 
 ORDER BY p.`elevation` DESC;
 
 -- 13
 SELECT mc.`country_code`, COUNT(m.`mountain_range`) AS 'mountain_range'
 FROM `mountains_countries` AS mc
 JOIN `mountains` AS m 
 ON mc.`mountain_id` = m.`id`
 WHERE mc.`country_code` IN ('BG', 'US', 'RU')
 GROUP BY mc.`country_code`
 ORDER BY COUNT(m.`mountain_range`) DESC; 
 
-- 14 
 SELECT c.`country_name`, r.`river_name` FROM `countries` AS c
 LEFT JOIN `countries_rivers` AS cr 
 ON cr.`country_code` = c.`country_code`
 LEFT JOIN `rivers` AS r 
 ON r.`id` = cr.`river_id`
 WHERE c.`continent_code` = 'AF'
 ORDER BY c.`country_name` LIMIT 5;
 
 -- 16
SELECT 
    COUNT(*) AS 'country_count'
FROM
    (SELECT 
        mc.`country_code` AS 'mc_country_code'
    FROM
        `mountains_countries` AS mc
    GROUP BY mc.`country_code`) AS d
        RIGHT JOIN
    `countries` AS c ON c.`country_code` = d.`mc_country_code`
WHERE
    d.`mc_country_code` IS NULL;
 
-- 17
 SELECT 
    c.`country_name`,
    MAX(p.`elevation`) AS 'highest_peak_elevation',
    MAX(r.`length`) AS 'longest_river_length'
FROM
    `countries` AS c
        JOIN
    `countries_rivers` AS cr 
    ON c.`country_code` = cr.`country_code`
        JOIN
    `rivers` AS r ON cr.`river_id` = r.`id`
        JOIN
    `mountains_countries` AS mc ON mc.`country_code` = c.`country_code`
        JOIN
    `mountains` AS m ON mc.`mountain_id` = m.`id`
        JOIN
    `peaks` AS p ON m.`id` = p.`mountain_id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;


