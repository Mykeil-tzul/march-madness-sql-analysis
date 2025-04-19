/*
 Query 08: Coaches with Multiple Sweet 16+ Runs
 Description: Lists coaches who’ve led two or more different schools to the Sweet 16 or beyond,
              along with the names of those schools.
*/

WITH sweet_16_teams AS (
  -- Every team that reached Sweet 16 or later
  SELECT DISTINCT season, teamid
  FROM (
    SELECT season, wteamid AS teamid, daynum FROM mncaatourneycompactresults
    UNION ALL
    SELECT season, lteamid AS teamid, daynum FROM mncaatourneycompactresults
  ) AS games
  WHERE daynum >= 136
),

coach_achievements AS (
  -- Match those teams to their coaches
  SELECT
    c.coachname,
    c.teamid
  FROM mteamcoaches AS c
  JOIN sweet_16_teams AS s
    ON c.season = s.season
   AND c.teamid = s.teamid
)

SELECT
  ca.coachname,
  COUNT(DISTINCT ca.teamid)        AS different_schools,
  LISTAGG(
    DISTINCT t.teamname,
    ', '
  ) WITHIN GROUP (ORDER BY t.teamname) AS schools
FROM coach_achievements ca
JOIN mteams t
  ON ca.teamid = t.teamid
GROUP BY ca.coachname
HAVING COUNT(DISTINCT ca.teamid) >= 2
ORDER BY different_schools DESC, ca.coachname;
