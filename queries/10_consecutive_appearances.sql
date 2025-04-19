/*
 Query 10: Longest Consecutive Appearance Streaks
 Description: Finds the top 10 teams with the longest streaks of consecutive
              NCAA Tournament appearances.
*/
WITH team_seasons AS (
  -- Every tournament appearance by team
  SELECT season, teamid
  FROM mncaatourneyseeds
),
ranked_seasons AS (
  -- Rank each team’s seasons ascending
  SELECT
    ts.teamid,
    ts.season,
    ROW_NUMBER() OVER (
      PARTITION BY ts.teamid
      ORDER BY ts.season
    ) AS rn
  FROM team_seasons ts
),
streak_groups AS (
  -- seasons that differ from their row_number by the same offset form a streak
  SELECT
    teamid,
    season,
    season - rn AS grp
  FROM ranked_seasons
),
streak_lengths AS (
  -- Compute each team’s streak length and span
  SELECT
    teamid,
    MIN(season) AS start_season,
    MAX(season) AS end_season,
    COUNT(*)    AS streak_length
  FROM streak_groups
  GROUP BY teamid, grp
)
SELECT
  t.teamname,
  sl.streak_length              AS consecutive_appearances,
  sl.start_season,
  sl.end_season
FROM streak_lengths sl
JOIN mteams t
  ON sl.teamid = t.teamid
ORDER BY sl.streak_length DESC, sl.start_season ASC
LIMIT 10;
