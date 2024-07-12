# Grouping by geography
Unlike PostGIS, BigQuery does not support grouping by geometry. Rather than casting the geometry to a string, the most efficient method is to make use of the `ANY_VALUE()` function. 

If you are grouping by geometry, you are assuming that the geometries are identical therefore it doesn't matter which geometry you select.

```
SELECT 
id, 
ANY_VALUE(geom) AS geom
FROM table 
GROUP BY geo_id
```