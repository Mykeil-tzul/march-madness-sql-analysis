/*
 Query 06: Elite Eight Appearances by Conference (Last 20 Seasons)
 Description: Counts how many times each conference had a team in the Elite Eight 
              over the past 20 tournaments, and ranks them by appearance count.
*/

WITH tournament_range AS (
  -- Define the most recent 20‐season window dynamically
  SELECT
    MAX(season) - 19 AS start_season,
    MAX(season)     AS end_season
  FROM mncaatourneycompactresults
),

elite_eight_games AS (
  -- All Elite Eight matchups (daynum = 136) in that window
  SELECT
    season,
    wteamid AS teamid
  FROM mncaatourneycompactresults r
  JOIN tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  WHERE r.daynum = 136

  UNION ALL

  SELECT
    season,
    lteamid AS teamid
  FROM mncaatourneycompactresults r
  JOIN tournament_range tr
    ON r.season BETWEEN tr.start_season AND tr.end_season
  WHERE r.daynum = 136
),

conference_appearances AS (
  -- Map each Elite Eight team to its conference and count appearances
  SELECT
    c.description     AS conference_name,
    COUNT(*)          AS elite_eight_appearances
  FROM elite_eight_games ee
  JOIN mteamconferences tc
    ON ee.teamid = tc.teamid
   AND ee.season = tc.season
  JOIN conferences c
    ON tc.confabbrev = c.confabbrev
  GROUP BY c.description
)

SELECT
  conference_name,
  elite_eight_appearances
FROM conference_appearances
ORDER BY elite_eight_appearances DESC;
