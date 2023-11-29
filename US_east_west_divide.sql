CREATE TABLE A.B.C CLUSTER BY h3 AS (
WITH
  total_pop AS (
  SELECT
    SUM(population) AS tot_pop
  FROM
    `population_table` ),
 
  cumulative_sum AS (
  SELECT
    geoid AS h3,
    population,
    SUM(population) OVER (ORDER BY ST_X(`carto-un`.carto.H3_CENTER(geoid)) ASC) AS cumulative_pop
  FROM
    `population_table`
    )
SELECT
  h3,
  cumulative_sum.population,
  cumulative_pop,
  CASE
    WHEN cumulative_pop >= tot_pop/2 THEN 'East'
  ELSE
  'West'
END
  AS east_west
FROM
  cumulative_sum,
  total_pop)
