# Nearest neighbour searching in Google BigQuery
Nearest neighbour or K-nearest neighbour searches are a common and extremely useful function within GIS. To perform a nearest neighbour search in BigQuery you can use the following:

```
SELECT 
  a.id, 
  ARRAY_AGG(b.id ORDER BY ST_Distance(a.geom, b.geom) LIMIT 1)
      [ORDINAL(1)] as neighbourr_id
FROM table_a a 
JOIN table_b b
ON ST_DWithin(a.geom, b.geom, 100) -- 100 is a search radius based on apriori knowledge. This helps to rapidly speed up the computation. 
GROUP BY a.id
```