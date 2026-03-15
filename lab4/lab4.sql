 -- Database Setup 
CREATE DATABASE lab4f;
GO
USE lab4f;
GO
-- Tables 
CREATE TABLE Driver (
    driver_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    date_of_birth DATE,
    license_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Car (
    car_id INT PRIMARY KEY IDENTITY(1,1),
    model VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    horsepower INT CHECK (horsepower > 0),
    top_speed INT CHECK (top_speed > 0),
    year_manufactured INT CHECK (year_manufactured >= 1980),
    price DECIMAL(10,2) CHECK (price > 0)
);

CREATE TABLE Driver_Car (
    driver_id INT,
    car_id INT,
    purchase_date DATE DEFAULT GETDATE(),
    PRIMARY KEY (driver_id, car_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE
);

CREATE TABLE Upgrade (
    upgrade_id INT PRIMARY KEY IDENTITY(1,1),
    upgrade_name VARCHAR(50) NOT NULL UNIQUE,
    upgrade_type VARCHAR(50) CHECK (
        upgrade_type IN ('Engine', 'Tires', 'Nitrous', 'Brakes', 'Aerodynamics')
    ),
    performance_boost INT CHECK (performance_boost > 0),
    price DECIMAL(10,2) CHECK (price > 0)
);

CREATE TABLE Car_Upgrade (
    car_id INT,
    upgrade_id INT,
    install_date DATE DEFAULT GETDATE(),
    PRIMARY KEY (car_id, upgrade_id),
    FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE,
    FOREIGN KEY (upgrade_id) REFERENCES Upgrade(upgrade_id) ON DELETE CASCADE
);

CREATE TABLE Race (
    race_id INT PRIMARY KEY IDENTITY(1,1),
    race_name VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    race_date DATETIME DEFAULT GETDATE(),
    track_length DECIMAL(5,2) CHECK (track_length > 0),
    max_participants INT CHECK (max_participants > 0)
);

CREATE TABLE Race_Participant (
    race_id INT,
    driver_id INT,
    car_id INT,
    PRIMARY KEY (race_id, driver_id, car_id),
    FOREIGN KEY (race_id) REFERENCES Race(race_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE
);

CREATE TABLE Race_Result (
    race_id INT,
    driver_id INT,
    finishing_position INT CHECK (finishing_position > 0),
    completion_time DECIMAL(6,2) CHECK (completion_time > 0),
    PRIMARY KEY (race_id, driver_id),
    FOREIGN KEY (race_id) REFERENCES Race(race_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE
);

CREATE TABLE Driver_Reward (
    driver_id INT,
    reward_name VARCHAR(50),
    reward_amount DECIMAL(10,2) CHECK (reward_amount >= 0),
    reward_date DATE DEFAULT GETDATE(),
    PRIMARY KEY (driver_id, reward_name, reward_date),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE
);

GO 
-- Insert Drivers (10) 
INSERT INTO Driver (first_name, last_name, country, date_of_birth, license_number)
VALUES 
('Dominic', 'Toretto', 'USA', '1999-08-29', 'DOM12345'),
('Brian', 'O’Conner', 'USA', '1998-07-14', 'BRIAN5678'),
('Letty', 'Ortiz', 'USA', '1997-05-12', 'LETTY9988'),
('Roman', 'Pearce', 'USA', '1996-11-22', 'ROMAN2233'),
('Tej', 'Parker', 'USA', '1995-03-09', 'TEJ4455'),
('Mia', 'Toretto', 'USA', '2000-02-10', 'MIA1122'),
('Han', 'Lue', 'Japan', '1990-07-01', 'HAN7788'),
('Deckard', 'Shaw', 'UK', '1988-10-15', 'DECK5555'),
('Owen', 'Shaw', 'UK', '1985-09-20', 'OWEN9999'),
('Gisele', 'Yashar', 'France', '1992-06-30', 'GISELE3333');
 
-- Insert Cars (10) 
INSERT INTO Car (model, brand, horsepower, top_speed, year_manufactured, price)
VALUES
('Charger R/T', 'Dodge', 900, 320, 1990, 75000.00),
('Supra MK4', 'Toyota', 800, 290, 1995, 60000.00),
('GTR R35', 'Nissan', 850, 315, 2018, 90000.00),
('Mustang GT', 'Ford', 700, 310, 2015, 65000.00),
('Lancer Evo', 'Mitsubishi', 680, 280, 2012, 55000.00),
('Camaro SS', 'Chevrolet', 720, 305, 2016, 62000.00),
('Skyline R34', 'Nissan', 810, 300, 2001, 58000.00),
('Challenger SRT', 'Dodge', 850, 325, 2019, 95000.00),
('RX-7', 'Mazda', 670, 290, 1999, 50000.00),
('GT-R50', 'Nissan', 900, 330, 2020, 120000.00);
 
-- Assign Cars to Drivers  
INSERT INTO Driver_Car (driver_id, car_id)
VALUES
(1, 1), (1, 3),        
(2, 2), (2, 4),         
(3, 5),                  
(4, 6),                 
(5, 7),                  
(6, 8),                  
(7, 9),                  
(8, 10);                 
 
-- Upgrades  
INSERT INTO Upgrade (upgrade_name, upgrade_type, performance_boost, price)
VALUES
('Twin Turbo Kit', 'Engine', 150, 10000),
('Nitrous System', 'Nitrous', 100, 5000),
('Racing Brakes', 'Brakes', 80, 4000),
('Sport Tires', 'Tires', 70, 3000),
('Aerodynamic Kit', 'Aerodynamics', 60, 2000);

-- Assign Upgrades to Cars  
INSERT INTO Car_Upgrade (car_id, upgrade_id)
VALUES
(1,1),(1,3),(1,4),  
(3,1),(3,2),           
(2,2),(2,4),           
(4,1),(4,5),          
(5,3),(5,4),           
(6,2),(6,3),          
(7,1),(7,5),           
(8,4),(8,5),           
(9,3),(9,2),           
(10,1),(10,5);          
 
-- Races (5) 
INSERT INTO Race (race_name, location, race_date, track_length, max_participants)
VALUES
('Underground Madness', 'Los Angeles', '2025-03-10 20:00:00', 5.5, 6),
('Desert Thunder', 'Nevada', '2025-04-15 21:00:00', 6.2, 8),
('City Drift', 'Tokyo', '2025-05-10 19:00:00', 4.8, 6),
('Coastline Clash', 'Miami', '2025-06-05 18:30:00', 7.0, 10),
('Mountain Run', 'Alps', '2025-07-12 16:00:00', 8.5, 8);
 
-- Register Participants in Races  
INSERT INTO Race_Participant (race_id, driver_id, car_id)
VALUES 
(1,1,1),(1,2,2),(1,3,5),(1,4,6),(1,5,7), 
(2,1,3),(2,2,4),(2,3,5),(2,6,8),(2,7,9), 
(3,1,1),(3,2,2),(3,3,5),(3,4,6),(3,8,10), 
(4,1,3),(4,2,4),(4,5,7),(4,6,8),(4,7,9), 
(5,1,1),(5,2,2),(5,3,5),(5,4,6),(5,5,7);
 
-- Race Results 
INSERT INTO Race_Result (race_id, driver_id, finishing_position, completion_time)
VALUES 
(1,1,2,182.75),(1,2,1,180.50),(1,3,3,185.20),(1,4,4,186.00),(1,5,5,187.10),
(2,1,1,178.40),(2,2,2,179.90),(2,3,3,182.00),(2,6,4,184.50),(2,7,5,183.30),
(3,1,1,179.00),(3,2,2,181.50),(3,3,3,183.00),(3,4,4,185.20),(3,8,5,186.50),
(4,1,2,180.10),(4,2,1,179.20),(4,5,3,182.40),(4,6,4,184.00),(4,7,5,183.80),
(5,1,1,177.50),(5,2,2,179.00),(5,3,3,181.00),(5,4,4,183.50),(5,5,5,182.00);
 
-- Driver Rewards 
INSERT INTO Driver_Reward (driver_id, reward_name, reward_amount)
VALUES
(1,'Champion Cup',15000),(2,'Fastest Lap',12000),(3,'Best Drifter',9000),
(4,'Runner-Up',8000),(5,'Speed King',7500),(6,'Consistent Racer',6000),
(7,'Sharp Turns',5000),(8,'Top Finisher',7000),(9,'Overdrive',6500),(10,'Trail Blazer',5500);

GO

-- Q1

SELECT D.first_name, D.last_name, C.model FROM Driver D 
INNER JOIN Driver_Car DC ON D.driver_id = DC.driver_id 
INNER JOIN Car C ON DC.car_id = C.car_id


-- Q2

SELECT R.race_name, COUNT(RP.driver_id) as TotalParticipants
FROM Race R LEFT JOIN Race_Participant RP ON R.race_id = RP.race_id
GROUP BY R.race_name

-- Q3

SELECT R.race_name, D.first_name, D.last_name
FROM Race R
INNER JOIN Race_Participant RP ON R.race_id = RP.race_id
INNER JOIN Driver D ON D.driver_id = RP.driver_id
INNER JOIN Race_Result RR ON RP.race_id = RR.race_id 
    AND RP.driver_id = RR.driver_id 
WHERE RR.completion_time = (
    SELECT MIN(subRR.completion_time)
    FROM Race_Result subRR
    WHERE subRR.race_id = RR.race_id 
)

-- Q4

SELECT D.first_name, D.last_name, SUM(DR.reward_amount) as TotalAmount FROM
Driver D INNER JOIN Driver_Reward DR ON D.driver_id = DR.driver_id
GROUP BY D.first_name, D.last_name

-- Q5

SELECT C.model, U.upgrade_name, U.upgrade_type
FROM Car C JOIN Car_Upgrade CU ON C.car_id = CU.car_id
JOIN Upgrade U ON CU.upgrade_id = U.upgrade_id

-- Q6

SELECT D.first_name, D.last_name FROM
Driver D JOIN Race_Participant RP ON D.driver_id = RP.driver_id
GROUP BY D.first_name, D.last_name, RP.driver_id
HAVING COUNT(RP.race_id) >= 2

-- Q7

SELECT R.race_name, AVG(RR.completion_time) as AverageCompletionTime
FROM Race R INNER JOIN Race_Result RR ON R.race_id = RR.race_id 
GROUP BY R.race_name

-- Q8

SELECT D.first_name, D.last_name
FROM Driver D JOIN Driver_Car DC ON D.driver_id = DC.driver_id
JOIN Car C ON DC.car_id = C.car_id
WHERE C.price IN (
	SELECT MAX(price)
	FROM Car
)

-- Q9

SELECT D.first_name, D.last_name, SUM(DR.reward_amount) as TotalAmount FROM
Driver D INNER JOIN Driver_Reward DR ON D.driver_id = DR.driver_id
GROUP BY D.first_name, D.last_name
ORDER BY TotalAmount DESC

-- Q10

SELECT D.first_name, D.last_name
FROM Driver D JOIN Driver_Car DC ON D.driver_id = DC.driver_id
JOIN Car C ON DC.car_id = C.car_id
GROUP BY D.first_name, D.last_name
HAVING COUNT(C.brand) >= 2

-- Q11

SELECT D.first_name, D.last_name
FROM Driver D JOIN Race_Participant RP ON D.driver_id = RP.driver_id
GROUP BY D.first_name, D.last_name
HAVING COUNT(Rp.race_id) = (
	SELECT COUNT(*) FROM Race
)

-- Q12 

SELECT TOP 3 D.first_name, D.last_name, AVG(RR.completion_time) AS AvgCompletionTime
FROM Driver D
JOIN Race_Result RR ON D.driver_id = RR.driver_id
GROUP BY D.first_name, D.last_name
ORDER BY AvgCompletionTime ASC;

-- Q13
SELECT DISTINCT D.first_name, D.last_name
FROM Driver D
JOIN Driver_Car DC ON D.driver_id = DC.driver_id
JOIN Car_Upgrade CU ON DC.car_id = CU.car_id
GROUP BY D.first_name, D.last_name
HAVING COUNT(DISTINCT CU.upgrade_id) >= 2;