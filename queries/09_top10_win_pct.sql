/*
 Query 01: Top 10 Schools by Win Percentage (2016–2025)
 Description: Calculates each school’s tournament wins divided by games played over the last 10 seasons, then lists the top 10.
*/

WITH tournament_range AS (
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

final_four_teams AS (
  SELECT season, wteamid AS teamid
  FROM   mncaatourneycompactresults r
  JOIN   tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  WHERE  r.daynum >= 139

  UNION

  SELECT season, lteamid AS teamid
  FROM   mncaatourneycompactresults r
  JOIN   tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  WHERE  r.daynum >= 139
),

seed_appearances AS (
  SELECT
    CAST(SUBSTRING(s.seed,2,2) AS INTEGER) AS seed_number,
    COUNT(*) AS appearances
  FROM final_four_teams f
  JOIN mncaatourneyseeds s
    ON f.teamid = s.teamid
   AND f.season = s.season
  GROUP BY seed_number
)

SELECT
  seed_number,
  appearances,
  ROUND(
    appearances * 100.0
    / ( (SELECT (end_season - start_season + 1) * 4
         FROM tournament_range) ),
    2
  ) AS pct_of_all_slots
FROM seed_appearances
ORDER BY appearances DESC
LIMIT 10;
