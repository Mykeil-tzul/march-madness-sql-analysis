/*
 Query 03: Teams with Most Upsets
 Description: Identifies the teams that have pulled off the most “upsets” (winning as a lower seed) across all tournaments.
*/

WITH tournament_range AS (
  -- Last 10 tournaments
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

upset_games AS (
  -- All games in window where a seed‑9+ team beats a lower seed
  SELECT
    r.season,
    r.wteamid      AS teamid,
    CAST(SUBSTRING(ws.seed, 2, 2) AS INT) AS winner_seed,
    CAST(SUBSTRING(ls.seed, 2, 2) AS INT) AS loser_seed
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
    CAST(SUBSTRING(ws.seed, 2, 2) AS INT) >= 9  -- underdog
    AND CAST(SUBSTRING(ws.seed, 2, 2) AS INT)
        > CAST(SUBSTRING(ls.seed, 2, 2) AS INT)  -- true upset
),

underdog_upsets AS (
  SELECT
    teamid,
    COUNT(*)           AS total_upsets,
    MIN(winner_seed)   AS best_seed_upset  -- lowest numeric seed they've pulled off
  FROM upset_games
  GROUP BY teamid
  HAVING COUNT(*) >= 2   -- at least two upsets to make the cut
)

SELECT
  t.teamname,
  u.total_upsets,
  u.best_seed_upset AS lowest_seed_number_in_upset
FROM underdog_upsets AS u
JOIN mteams           AS t
  ON u.teamid = t.teamid
ORDER BY
  u.total_upsets DESC,
  u.best_seed_upset DESC
LIMIT 10;