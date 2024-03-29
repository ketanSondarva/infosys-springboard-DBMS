
-- Exercise 1:

CREATE TABLE IF NOT EXISTS Player (
    PID INTEGER PRIMARY KEY,
    PName VARCHAR(20) NOT NULL,
    Ranking INTEGER 
);

-- Excercise 2:

CREATE TABLE IF NOT EXISTS Tournament (
    TID INTEGER PRIMARY KEY,
    Tname VARCHAR(20) NOT NULL,
    StartDt DATE NOT NULL,
    EndDt DATE NOT NULL,
    Prize INTEGER NOT NULL
);

DROP TABLE IF EXISTS Tournament;

-- EXERCISE 3:

CREATE TABLE IF NOT EXISTS Match1 (
    MID INTEGER,
    TID INTEGER,
    Player1 INTEGER,
    Player2 INTEGER,
    MatchDt DATE NOT NULL,
    Winner INTEGER,
    Score VARCHAR(30) NOT NULL,
    CONSTRAINT Match_tournament_fk FOREIGN KEY (TID) REFERENCES Tournament (TID),
    CONSTRAINT Match_winner_fk FOREIGN KEY (Winner) REFERENCES Player (PID),
    CONSTRAINT Match_pk PRIMARY KEY (MID, TID)
);

DROP TABLE IF EXISTS Match1;


