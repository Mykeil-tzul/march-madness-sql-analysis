/*
 Query 01: Top 10 Schools by Win Percentage (2016–2025)
 Description: Calculates each school’s tournament wins divided by games played over the last 10 seasons, then lists the top 10.
*/

WITH tournament_range AS (
  -- Dynamically define the last 10 seasons
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

team_records AS (
  -- Combine wins and losses into one stream with an is_win flag
  SELECT
    teamid,
    COUNT(*)                      AS total_games,
    SUM(is_win)                   AS total_wins
  FROM (
    SELECT season, wteamid AS teamid, 1 AS is_win
    FROM   mncaatourneycompactresults r
    JOIN   tournament_range tr 
      ON r.season BETWEEN tr.start_season AND tr.end_season

    UNION ALL

    SELECT season, lteamid AS teamid, 0 AS is_win
    FROM   mncaatourneycompactresults r
    JOIN   tournament_range tr
      ON r.season BETWEEN tr.start_season AND tr.end_season
  ) AS games
  GROUP BY teamid
  HAVING COUNT(*) >= 5   -- only include teams with at least 5 tourney games
)

SELECT
  t.teamname,
  r.total_wins,
  r.total_games,
  ROUND(100.0 * r.total_wins / r.total_games, 2) AS win_percentage
FROM team_records r
JOIN mteams        t ON r.teamid = t.teamid
ORDER BY win_percentage DESC, total_games DESC
LIMIT 10;

