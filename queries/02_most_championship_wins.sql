/*
 Query 02: Most Championships (Last 10 Seasons)
 Description: Determines which teams have won the NCAA championship most frequently
              over the last 10 tournaments, and their average titles per year.
*/

WITH tournament_range AS (
  -- Dynamically grab the last 10 seasons
  SELECT
    MAX(season) - 9 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

tourney_games AS (
  -- All tournament games in that window
  SELECT
    season,
    daynum,
    wteamid,
    lteamid
  FROM mncaatourneycompactresults r
  JOIN tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
),

championship_games AS (
  -- Pick the single game with the highest daynum per season → the title game
  SELECT
    season,
    wteamid AS champion_teamid
  FROM (
    SELECT
      season,
      daynum,
      wteamid,
      ROW_NUMBER() OVER (PARTITION BY season ORDER BY daynum DESC) AS rn
    FROM tourney_games
  ) x
  WHERE rn = 1
)

SELECT
  t.teamname                       AS champion,
  COUNT(*)                         AS titles_last_10yrs,
  ROUND(
    COUNT(*) * 1.0
    / ( (SELECT end_season - start_season + 1 FROM tournament_range) ),
    2
  )                                 AS avg_titles_per_year
FROM championship_games cg
JOIN mteams               t ON cg.champion_teamid = t.teamid
GROUP BY t.teamname
ORDER BY titles_last_10yrs DESC
LIMIT 10;
