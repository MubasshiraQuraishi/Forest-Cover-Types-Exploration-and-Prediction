SELECT * FROM forest_cover.forest_cover;
Use forest_cover
ALTER TABLE forest_cover
RENAME TO data

-- Rows Counting
SELECT COUNT(*) AS row_count
FROM data

-- Columns Counting
SELECT COUNT(*) AS column_count
FROM information_schema.columns 
WHERE TABLE_SCHEMA = "forest_cover"
AND TABLE_NAME = "data"

-- Descriptive Statistics:
-- What are the average, maximum, minimum, and standard deviation values for numeric features?
SELECT 
AVG(Elevation) AS Average_elevation,
MAX(Elevation) AS Maximum_elevation,
MIN(Elevation) AS Minimum_elevation,
STDDEV(Elevation) AS Std_Deviation_elevation
FROM data

-- Distribution Analysis:
-- How is the distribution of the target variable 'Cover_Type'?
SELECT cover_type, COUNT(*) AS count
FROM data 
GROUP BY cover_type

-- Correlation Analysis:
-- Are there correlations between specific numeric features, such as elevation and slope?
SELECT 
    ROUND(AVG(Elevation * Slope) / (STDDEV(Elevation) * STDDEV(Slope)), 4) AS correlation_elevation_slope,
    ROUND(AVG(Horizontal_Distance_To_Hydrology * Vertical_Distance_To_Hydrology)/ (STDDEV(Horizontal_Distance_To_Hydrology) * STDDEV(Vertical_Distance_To_Hydrology)),4) AS correlation_hydrology
FROM data;

-- Outlier Detection:
SELECT
    Elevation,
    Slope
FROM data
WHERE Elevation > (SELECT AVG(Elevation) + 2 * STDDEV(Elevation) FROM data)
   OR Slope > (SELECT AVG(Slope) + 2 * STDDEV(Slope) FROM data);
   
-- Horizontal Distance to Hydrology Histogram 
SELECT
  FLOOR(Horizontal_Distance_To_Hydrology / 10) * 10 AS bin_start,
  FLOOR(Horizontal_Distance_To_Hydrology / 10) * 10 + 10 AS bin_end,
  COUNT(*) AS bin_count
FROM
  DATA
GROUP BY
  bin_start, bin_end
ORDER BY
  bin_start;
  
  SELECT max(Hillshade_9am)
  FROM DATA

