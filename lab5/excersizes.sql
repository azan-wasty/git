--Q1
SELECT TOP 1 C.Name AS VillainName, COUNT(*) AS DefeatedFamilyMembers
FROM Creature C
JOIN FamilyRelation FR ON C.CreatureID = FR.Creature1ID
JOIN Fight F ON FR.Creature2ID = F.Creature1ID OR FR.Creature2ID = F.Creature2ID
WHERE C.Type = 'Villain'
AND FR.Creature2ID <> F.WinnerID
GROUP BY C.Name
ORDER BY DefeatedFamilyMembers DESC;

--Q2
SELECT TOP 1 C.Name AS StrongestDeadHero, COUNT(F.FightID) AS TotalWins
FROM Creature C
JOIN Fight F ON C.CreatureID = F.WinnerID
JOIN DeathLog D ON C.CreatureID = D.CreatureID
WHERE C.Type = 'Hero'
GROUP BY C.Name
ORDER BY TotalWins DESC;