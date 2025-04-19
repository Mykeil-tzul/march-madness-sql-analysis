/*
 Query 04: Underdog Upsets (Seed ≥ 9, Last 10 Seasons)
 Description: Identifies teams seeded 9 or higher that beat a lower seed, 
              counts each team’s total upsets and the “best” (lowest-numbered) seed they defeated.
*/

WITH tournament_range AS (
  -- Define the last 10 tournaments
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

upset_games AS (
  -- All games where a seed‑9+ team wins as the underdog
  SELECT
    r.season,
    r.wteamid      AS teamid,
    CAST(SUBSTRING(ws.seed, 2, 2) AS INTEGER) AS winner_seed,
    CAST(SUBSTRING(ls.seed, 2, 2) AS INTEGER) AS loser_seed
  FROM mncaatourneycompactresults AS r
  JOIN tournament_range AS tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  JOIN mncaatourneyseeds AS ws
    ON r.season = ws.season
   AND r.wteamid = ws.teamid
  JOIN mncaatourneyseeds AS ls
    ON r.season = ls.season
   AND r.lteamid = ls.teamid
  WHERE
    CAST(SUBSTRING(ws.seed, 2, 2) AS INTEGER) >= 9
    AND CAST(SUBSTRING(ws.seed, 2, 2) AS INTEGER)
        > CAST(SUBSTRING(ls.seed, 2, 2) AS INTEGER)
),

underdog_upsets AS (
  -- Aggregate by team: how many upsets and the “best” upset seed
  SELECT
    teamid,
    COUNT(*)           AS total_upsets,
    MIN(winner_seed)   AS best_seed_upset
  FROM upset_games
  GROUP BY teamid
  HAVING COUNT(*) >= 2   -- only teams with 2+ upsets
)

SELECT
  t.teamname,
  u.total_upsets,
  u.best_seed_upset  AS lowest_seed_number_in_upset
FROM underdog_upsets AS u
JOIN mteams AS t
  ON u.teamid = t.teamid
ORDER BY
  u.total_upsets DESC,
  u.best_seed_upset DESC
LIMIT 10;
