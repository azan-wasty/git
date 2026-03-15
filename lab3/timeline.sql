-- assuming that the cricket matches are sorted by Runs Sccored (as on match date is present)

SELECT 
    Title AS EventName,
    'Movie' AS EventType,
    ReleaseYear AS TimelineValue,
    Rating AS ExtraInfo
FROM Movies

UNION ALL

SELECT 
    Name AS EventName,
    'Cricket Match' AS EventType,
    RunsScored AS TimelineValue,
    WicketsTaken AS ExtraInfo
FROM Cricket

UNION ALL

SELECT 
    MissionName AS EventName,
    'Space Mission' AS EventType,
    LaunchYear AS TimelineValue,
    DurationDays AS ExtraInfo
FROM SpaceMissions

ORDER BY TimelineValue;