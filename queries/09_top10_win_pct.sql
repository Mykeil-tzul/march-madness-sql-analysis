/*
 Query 09: Top 10 Schools by Win Percentage (Last 10 Seasons)
 Description: Identifies schools with ≥5 tournament games in the last 10 seasons,
              ranked by win percentage.
*/
WITH tournament_range AS (
  -- Define the 10‐season window
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),
team_records AS (
  -- Aggregate wins and games per team
  SELECT
    teamid,
    COUNT(*)                 AS total_games,
    SUM(is_win)              AS total_wins
  FROM (
    SELECT season, wteamid AS teamid, 1 AS is_win
    FROM mncaatourneycompactresults r
    JOIN tournament_range tr 
      ON r.season BETWEEN tr.start_season AND tr.end_season

    UNION ALL

    SELECT season, lteamid AS teamid, 0 AS is_win
    FROM mncaatourneycompactresults r
    JOIN tournament_range tr 
      ON r.season BETWEEN tr.start_season AND tr.end_season
  ) AS games
  GROUP BY teamid
  HAVING COUNT(*) >= 5   -- only include teams with ≥5 games
)
SELECT
  t.teamname,
  r.total_wins,
  r.total_games,
  ROUND(100.0 * r.total_wins / r.total_games, 2) AS win_percentage
FROM team_records r
JOIN mteams t
  ON t.teamid = r.teamid
ORDER BY win_percentage DESC, total_games DESC
LIMIT 10;
