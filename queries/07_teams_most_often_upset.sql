/*
 Query 07: Teams Most Often Upset by Lower Seeds (Last 10 Seasons)
 Description: Identifies the top teams that lost as higher seeds to worse‐seeded opponents, 
              showing how many times they were upset and their average seed when upset.
*/

WITH tournament_range AS (
  -- Define the last 10 tournaments
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

upset_losses AS (
  -- Games where a higher‐seeded team lost to a lower seed
  SELECT
    r.season,
    r.lteamid   AS teamid,
    CAST(SUBSTRING(ls.seed, 2, 2) AS INTEGER) AS loser_seed,
    CAST(SUBSTRING(ws.seed, 2, 2) AS INTEGER) AS winner_seed
  FROM mncaatourneycompactresults r
  JOIN tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  JOIN mncaatourneyseeds ls
    ON r.season = ls.season
   AND r.lteamid = ls.teamid
  JOIN mncaatourneyseeds ws
    ON r.season = ws.season
   AND r.wteamid = ws.teamid
  WHERE
    CAST(SUBSTRING(ls.seed, 2, 2) AS INTEGER) 
      < CAST(SUBSTRING(ws.seed, 2, 2) AS INTEGER)
),

upset_victims AS (
  -- Aggregate by team: times upset and average seed when upset
  SELECT
    teamid,
    COUNT(*)                 AS times_upset,
    ROUND(AVG(loser_seed),2) AS avg_seed_when_upset
  FROM upset_losses
  GROUP BY teamid
  HAVING COUNT(*) >= 3      -- at least 3 such upsets
)

SELECT
  t.teamname,
  u.times_upset,
  u.avg_seed_when_upset
FROM upset_victims u
JOIN mteams t
  ON u.teamid = t.teamid
ORDER BY
  u.times_upset DESC,
  u.avg_seed_when_upset ASC
LIMIT 10;
