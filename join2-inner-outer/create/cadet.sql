CREATE TABLE IF NOT EXISTS `cadet` (
  `cadet_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL, --currently first and last name, could be two fields
  `gender` char(1) NOT NULL DEFAULT 'M', --should be set to 'M' or 'F', treat like ENUM()
  `callsign` TEXT DEFAULT NULL, 
  `army_id` INTEGER NOT NULL,
  PRIMARY KEY (`cadet_id`)
);

INSERT OR IGNORE INTO `cadet` VALUES(1, 'Andrew Wiggin', 'M', 'Ender', 1);
INSERT OR IGNORE INTO `cadet` VALUES(2, 'Julian Delphiki', 'M', 'Bean', 1);
INSERT OR IGNORE INTO `cadet` VALUES(3, 'Petra Arkanian', 'F', NULL, 3);
INSERT OR IGNORE INTO `cadet` VALUES(4, 'Alai', 'M', NULL, 2);
INSERT OR IGNORE INTO `cadet` VALUES(5, 'Bonito de Madrid', 'M', 'Bonzo', 2);
INSERT OR IGNORE INTO `cadet` VALUES(6, 'Dink Meeker', 'M', NULL, 1);
INSERT OR IGNORE INTO `cadet` VALUES(7, 'Carn Carby', 'M', NULL, 5);
INSERT OR IGNORE INTO `cadet` VALUES(8, 'Tom British', 'M', 'Crazy Tom', 1);
INSERT OR IGNORE INTO `cadet` VALUES(9, 'Han Tzu', 'M', 'Hot Soup', 1);
INSERT OR IGNORE INTO `cadet` VALUES(10, 'Rosen de Nose', 'M', 'Rose the Nose', 4);


CREATE TABLE IF NOT EXISTS `award` (
  `award_id` INTEGER NOT NULL,
  `cadet_id` INTEGER NOT NULL,
  `name` TEXT DEFAULT 'MVP',
  `battle_id` INTEGER DEFAULT NULL,
  `awarded` TEXT DEFAULT '2030-01-01', --date field
  PRIMARY KEY (`award_id`)
);

INSERT OR IGNORE INTO `award` VALUES(1, 1, 'MVP', 1, '2032-09-01');
INSERT OR IGNORE INTO `award` VALUES(2, 1, 'Academic Merit', NULL, '2032-09-01');
INSERT OR IGNORE INTO `award` VALUES(3, 1, 'MVP', 2, '2032-09-04');
INSERT OR IGNORE INTO `award` VALUES(4, 1, 'Pie Eating', NULL, '2032-09-04');
INSERT OR IGNORE INTO `award` VALUES(5, 1, 'MVP', 3, '2032-09-05');
INSERT OR IGNORE INTO `award` VALUES(6, 2, 'MVP', 4, '2032-09-06');
INSERT OR IGNORE INTO `award` VALUES(7, 3, 'MVP', 5, '2032-09-07');
INSERT OR IGNORE INTO `award` VALUES(8, 3, 'High Score - Arcade', NULL, '2032-09-08');
INSERT OR IGNORE INTO `award` VALUES(9, 3, 'Raquetball Tournament', NULL, '2032-09-08');
INSERT OR IGNORE INTO `award` VALUES(10, 3, 'Academic Merit', NULL, '2032-09-10');
INSERT OR IGNORE INTO `award` VALUES(11, 4, 'Academic Merit', NULL, '2032-09-10');
INSERT OR IGNORE INTO `award` VALUES(12, 6, 'Academic Merit', NULL, '2032-09-10');
INSERT OR IGNORE INTO `award` VALUES(13, 7, 'MVP', 9, '2032-09-13');
INSERT OR IGNORE INTO `award` VALUES(14, 7, 'MVP', 17, '2032-09-25');
INSERT OR IGNORE INTO `award` VALUES(15, 5, 'MVP', 5, '2032-09-07');
INSERT OR IGNORE INTO `award` VALUES(16, 9, 'Best Dressed', NULL, '2032-09-18');
INSERT OR IGNORE INTO `award` VALUES(17, 10, 'MVP', 18, '2032-09-26');
INSERT OR IGNORE INTO `award` VALUES(18, 5, 'MVP', 7, '2032-09-11');


CREATE TABLE IF NOT EXISTS `battle` (
  `battle_id` INTEGER NOT NULL,
  `name` TEXT DEFAULT NULL,
  `fought` TEXT DEFAULT '2030-01-01', --date field 
  `final` INTEGER DEFAULT 0, -- 0=unfought, 1=army1 win, 2=army2 win, 3=draw, -1=aborted
  `army1_id` INTEGER NOT NULL, --needs more normalization
  `army2_id` INTEGER NOT NULL, --needs more normalization
  PRIMARY KEY (`battle_id`)
);

INSERT OR IGNORE INTO `battle` VALUES(1, NULL, '2032-09-01', 1, 1, 2);

INSERT OR IGNORE INTO `battle` VALUES(2, NULL, '2032-09-04', 1, 1, 3);
INSERT OR IGNORE INTO `battle` VALUES(3, 'Spartan Surprise', '2032-09-05', 1, 1, 4);
INSERT OR IGNORE INTO `battle` VALUES(4, NULL, '2032-09-06', 1, 1, 5);
INSERT OR IGNORE INTO `battle` VALUES(5, NULL, '2032-09-07', 1, 2, 3);
INSERT OR IGNORE INTO `battle` VALUES(6, NULL, '2032-09-08', 2, 2, 4);

INSERT OR IGNORE INTO `battle` VALUES(7, 'Manic Monday', '2032-09-11', 1, 2, 5);
INSERT OR IGNORE INTO `battle` VALUES(8, NULL, '2032-09-12', 3, 3, 4);
INSERT OR IGNORE INTO `battle` VALUES(9, NULL, '2032-09-13', 2, 3, 5);
INSERT OR IGNORE INTO `battle` VALUES(10, NULL, '2032-09-14', 1, 4, 5);
INSERT OR IGNORE INTO `battle` VALUES(11, NULL, '2032-09-15', 1, 1, 2);

INSERT OR IGNORE INTO `battle` VALUES(12, NULL, '2032-09-18', 1, 1, 3);
INSERT OR IGNORE INTO `battle` VALUES(13, NULL, '2032-09-19', 1, 1, 4);
INSERT OR IGNORE INTO `battle` VALUES(14, 'Warrior Wednesday', '2032-09-20', 1, 1, 5);
INSERT OR IGNORE INTO `battle` VALUES(15, NULL, '2032-09-21', 1, 2, 3);
INSERT OR IGNORE INTO `battle` VALUES(16, NULL, '2032-09-22', 2, 2, 4);

INSERT OR IGNORE INTO `battle` VALUES(17, NULL, '2032-09-25', 3, 2, 5);
INSERT OR IGNORE INTO `battle` VALUES(18, NULL, '2032-09-26', 2, 3, 4);
INSERT OR IGNORE INTO `battle` VALUES(19, NULL, '2032-09-27', 1, 3, 5);
INSERT OR IGNORE INTO `battle` VALUES(20, 'Punch Drunk Rabbit', '2032-09-28', 1, 4, 5);
INSERT OR IGNORE INTO `battle` VALUES(21, NULL, '2032-09-29', 1, 1, 4);

CREATE TABLE IF NOT EXISTS `cadet_battle` (
  `cadet_battle_id` INTEGER NOT NULL, --this table has a unique id, but cadet_id and battle_id together are unique
  `cadet_id` INTEGER NOT NULL,
  `battle_id` INTEGER NOT NULL,
  `hits_taken` INTEGER DEFAULT 0, --0-6 hits from other cadets
  `frozen` INTEGER DEFAULT 0, --was the cadet frozen during battle?
  `frozen_by_id` INTEGER DEFAULT NULL, --cadet_id of cadet who froze this cadet
  `shots` INTEGER DEFAULT 0, --shots fired
  `hits_given` INTEGER DEFAULT 0, --shots that hit a cadet
  `freezes` INTEGER DEFAULT 0, --did any hits result in a freeze?
  `mvp` INTEGER DEFAULT 0, --boolean, if the cadet received an award 
  PRIMARY KEY (`cadet_battle_id`),
  UNIQUE(cadet_id, battle_id) ON CONFLICT REPLACE
);
--a1b1
INSERT OR IGNORE INTO `cadet_battle` VALUES(1, 1, 1, 2, 0, NULL, 6, 4, 1, 1);
INSERT OR IGNORE INTO `cadet_battle` VALUES(2, 2, 1, 4, 1, 4, 7, 1, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(3, 6, 1, 0, 0, NULL, 19, 6, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(4, 8, 1, 6, 1, 5, 11, 2, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(5, 9, 1, 1, 0, NULL, 6, 1, 0, 0);
--a2b1
INSERT OR IGNORE INTO `cadet_battle` VALUES(6, 4, 1, 6, 1, 1, 15, 12, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(7, 5, 1, 5, 1, 3, 20, 10, 1, 0);

--a1b2
INSERT OR IGNORE INTO `cadet_battle` VALUES(8, 1, 2, 3, 0, NULL, 15, 5, 0, 1);
INSERT OR IGNORE INTO `cadet_battle` VALUES(9, 2, 2, 2, 0, NULL, 12, 8, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(10, 6, 2, 1, 0, NULL, 5, 4, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(11, 8, 2, 6, 1, 3, 4, 3, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(12, 9, 2, 2, 1, 3, 14, 6, 0, 0);
--a3b2
INSERT OR IGNORE INTO `cadet_battle` VALUES(13, 3, 2, 2, 1, 2, 12, 5, 2, 0);

--a1b3
INSERT OR IGNORE INTO `cadet_battle` VALUES(14, 1, 3, 2, 0, NULL, 10, 4, 1, 1);
INSERT OR IGNORE INTO `cadet_battle` VALUES(15, 2, 3, 3, 0, NULL, 8, 5, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(16, 6, 3, 4, 1, 10, 11, 7, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(17, 8, 3, 0, 0, NULL, 9, 3, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(18, 9, 3, 1, 0, NULL, 12, 8, 0, 0);
--a4b3
INSERT OR IGNORE INTO `cadet_battle` VALUES(19, 10, 3, 6, 1, 1, 6, 6, 1, 0);

--a1b4
INSERT OR IGNORE INTO `cadet_battle` VALUES(20, 1, 4, 1, 0, NULL, 9, 7, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(21, 2, 4, 4, 0, NULL, 19, 18, 1, 1);
INSERT OR IGNORE INTO `cadet_battle` VALUES(22, 6, 4, 5, 1, 7, 8, 4, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(23, 8, 4, 4, 1, 7, 17, 6, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(24, 9, 4, 2, 0, NULL, 4, 4, 0, 0);
--a5b4
INSERT OR IGNORE INTO `cadet_battle` VALUES(25, 7, 4, 4, 1, 2, 15, 12, 2, 0);

--a2b5
INSERT OR IGNORE INTO `cadet_battle` VALUES(26, 4, 5, 3, 1, 3, 4, 3, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(27, 5, 5, 2, 0, NULL, 12, 9, 0, 0);
--a3b5
INSERT OR IGNORE INTO `cadet_battle` VALUES(28, 3, 5, 3, 0, NULL, 10, 8, 1, 1);

--a2b6
INSERT OR IGNORE INTO `cadet_battle` VALUES(29, 4, 6, 4, 1, 10, 1, 1, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(30, 5, 6, 2, 0, NULL, 10, 1, 0, 0);
--a4b6
INSERT OR IGNORE INTO `cadet_battle` VALUES(31, 10, 6, 3, 1, NULL, 11, 10, 1, 0);

--a2b7
INSERT OR IGNORE INTO `cadet_battle` VALUES(32, 4, 7, 6, 1, 7, 18, 10, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(33, 5, 7, 4, 0, NULL, 17, 15, 0, 1);
--a5b7
INSERT OR IGNORE INTO `cadet_battle` VALUES(34, 7, 7, 2, 0, NULL, 6, 6, 1, 0);

--a3b8
INSERT OR IGNORE INTO `cadet_battle` VALUES(35, 3, 8, 2, 0, NULL, 7, 6, 1, 0);
--a4b8
INSERT OR IGNORE INTO `cadet_battle` VALUES(36, 10, 8, 5, 1, 3, 13, 9, 0, 0);

--a3b9
INSERT OR IGNORE INTO `cadet_battle` VALUES(37, 3, 9, 2, 0, NULL, 16, 9, 0, 0);
--a5b9
INSERT OR IGNORE INTO `cadet_battle` VALUES(38, 7, 9, 4, 0, NULL, 4, 3, 0, 1);

--a4b10
INSERT OR IGNORE INTO `cadet_battle` VALUES(39, 10, 10, 6, 1, 10, 7, 5, 0, 0);
--a5b10
INSERT OR IGNORE INTO `cadet_battle` VALUES(40, 7, 10, 4, 0, NULL, 16, 12, 1, 0);

--a1b11
INSERT OR IGNORE INTO `cadet_battle` VALUES(1, 1, 11, 5, 1, 4, 4, 4, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(2, 2, 11, 0, 0, NULL, 12, 10, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(3, 6, 11, 4, 1, 4, 15, 10, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(4, 8, 11, 3, 0, NULL, 14, 11, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(5, 9, 11, 6, 1, 5, 12, 9, 0, 0);
--a2b11
INSERT OR IGNORE INTO `cadet_battle` VALUES(6, 4, 11, 3, 1, 2, 9, 7, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(7, 5, 11, 2, 0, NULL, 7, 7, 1, 0);

--a1b12
INSERT OR IGNORE INTO `cadet_battle` VALUES(8, 1, 12, 2, 0, NULL, 15, 6, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(9, 2, 12, 3, 0, NULL, 13, 12, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(10, 6, 12, 6, 1, 3, 10, 10, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(11, 8, 12, 1, 0, NULL, 6, 6, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(12, 9, 12, 4, 0, NULL, 16, 14, 0, 0);
--a3b12
INSERT OR IGNORE INTO `cadet_battle` VALUES(13, 3, 12, 4, 1, 9, 17, 13, 1, 0);

--a1b13
INSERT OR IGNORE INTO `cadet_battle` VALUES(14, 1, 13, 1, 0, NULL, 7, 6, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(15, 2, 13, 4, 0, NULL, 8, 7, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(16, 6, 13, 3, 0, NULL, 15, 7, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(17, 8, 13, 4, 1, 10, 2, 2, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(18, 9, 13, 2, 0, NULL, 12, 9, 0, 0);
--a4b13
INSERT OR IGNORE INTO `cadet_battle` VALUES(19, 10, 13, 5, 0, 6, 15, 14, 1, 0);

--a1b14
INSERT OR IGNORE INTO `cadet_battle` VALUES(20, 1, 14, 1, 0, NULL, 13, 11, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(21, 2, 14, 5, 0, NULL, 17, 15, 1, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(22, 6, 14, 6, 1, 4, 8, 8, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(23, 8, 14, 4, 1, 4, 10, 7, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(24, 9, 14, 3, 1, 4, 17, 13, 0, 0);
--a5b14
INSERT OR IGNORE INTO `cadet_battle` VALUES(25, 7, 14, 4, 0, 2, 13, 9, 3, 0);

--a2b15
INSERT OR IGNORE INTO `cadet_battle` VALUES(26, 4, 15, 5, 1, 3, 13, 9, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(27, 5, 15, 4, 0, NULL, 9, 8, 0, 0);
--a3b15
INSERT OR IGNORE INTO `cadet_battle` VALUES(28, 3, 15, 3, 0, NULL, 6, 6, 1, 0);

--a2b16
INSERT OR IGNORE INTO `cadet_battle` VALUES(29, 4, 16, 6, 1, 10, 16, 14, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(30, 5, 16, 3, 0, NULL, 14, 12, 0, 0);
--a4b16
INSERT OR IGNORE INTO `cadet_battle` VALUES(31, 10, 16, 2, 0, NULL, 10, 8, 1, 0);

--a2b17
INSERT OR IGNORE INTO `cadet_battle` VALUES(32, 4, 17, 3, 1, 7, 8, 7, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(33, 5, 17, 2, 0, NULL, 7, 6, 0, 0);
--a5b17
INSERT OR IGNORE INTO `cadet_battle` VALUES(34, 7, 17, 4, 0, NULL, 17, 16, 1, 1);

--a3b18
INSERT OR IGNORE INTO `cadet_battle` VALUES(35, 3, 18, 5, 1, 10, 5, 3, 0, 0);
--a4b18
INSERT OR IGNORE INTO `cadet_battle` VALUES(36, 10, 18, 3, 0, NULL, 12, 11, 1, 1);

--a3b19
INSERT OR IGNORE INTO `cadet_battle` VALUES(37, 3, 19, 2, 0, NULL, 15, 10, 0, 0);
--a5b19
INSERT OR IGNORE INTO `cadet_battle` VALUES(38, 7, 19, 2, 0, NULL, 11, 9, 0, 0);

--a4b20
INSERT OR IGNORE INTO `cadet_battle` VALUES(39, 10, 20, 3, 0, NULL, 9, 8, 0, 0);
--a5b20
INSERT OR IGNORE INTO `cadet_battle` VALUES(40, 7, 20, 2, 0, NULL, 5, 5, 0, 0);

--a1b21
INSERT OR IGNORE INTO `cadet_battle` VALUES(41, 1, 21, 3, 0, NULL, 15, 15, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(42, 2, 21, 4, 1, 10, 4, 3, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(43, 6, 21, 5, 1, 10, 5, 4, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(44, 8, 21, 4, 1, 10, 10, 9, 0, 0);
INSERT OR IGNORE INTO `cadet_battle` VALUES(45, 9, 21, 2, 0, NULL, 6, 4, 0, 0);
--a4b21
INSERT OR IGNORE INTO `cadet_battle` VALUES(46, 10, 21, 3, 0, NULL, 15, 15, 3, 0);

CREATE TABLE IF NOT EXISTS `army` (
  `army_id` INTEGER NOT NULL,
  `name` TEXT DEFAULT 'MVP',
  `commander_cadet_id` INTEGER NOT NULL,
  PRIMARY KEY (`army_id`)
);

INSERT OR IGNORE INTO `army` VALUES(1, 'Dragon', 1);
INSERT OR IGNORE INTO `army` VALUES(2, 'Salamander', 5);
INSERT OR IGNORE INTO `army` VALUES(3, 'Phoenix', 3);
INSERT OR IGNORE INTO `army` VALUES(4, 'Rat', 10);
INSERT OR IGNORE INTO `army` VALUES(5, 'Rabbit', 7);
