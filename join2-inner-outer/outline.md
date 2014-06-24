Joins: Inner vs. Outer Joins
============================

This lesson builds on the previous lesson about joins, introducing the Outer Join concept. The database uses a "Battle School" as the example.

#Overview

1. What is an Outer Join for?
2. Live demo
3. Syntax review
4. Code challenge

##What is an Outer Join for?

* Show all of A, and include B if it exists, matching on a condition.  
  *e.g. "Show a list of all cadets and awards they have won, if any."*
* Inner Joins include just those rows that match. Even if some rows from table A meet the criteria, an Inner Join would not include them unless there is a corresponding row in table B.  
  *e.g. an Inner Join would ONLY show cadets who have won awards*
* Outer Joins include all matching rows from the table on the Left; a match on the Right is not needed.  
  *i.e. All cadets will be shown, their awards only appear if they exist.*
* The most common type of Outer Join is a Left Join. SQLite only implements a Left Outer Join.
* You may use `LEFT JOIN` and `LEFT OUTER JOIN` interchangeably in SQLite.  
* Inner Joins can be reordered without affecting the results, but for Outer Joins the ordering of the tables matters.  
  *i.e. Placing awards on the Left would mean all awards were included, not all Cadets.*
* In a Left join, you want to use the ON or USING syntax. If you use WHERE, you may omit rows.  
  *i.e. If a row in the `award` table is NULL, its `cadet_id` cannot be equal to an `id` in the `cadet` table.*

##Live demo

1. **Show a list of 10 cadets and awards they have won, if any.**
  1. Decide which table to select FROM, and which table to LEFT JOIN.  
    `cadet` and `award`
  2. Make sure you place the table with potential NULL columns on the Right.  
    `award` may not have rows for every `cadet`, or may have multiple matches for one `cadet`.
  3. Remember to use the ON or USING keywords to specify the conditions for the LEFT JOIN. 
    `FROM cadet, LEFT OUTER JOIN award ON award.cadet_id = cadet.id` 
  4. Specify the WHERE clause(s).  
    `WHERE cadet.name IS NOT NULL` i.e. show all Cadets
  5. Decide which field(s) to SELECT. 
    `SELECT cadet.id, cadet.name, cadet.callsign, award.name`  
  6. Decide which field(s) to ORDER BY.  
    `ORDER BY cadet.name`
  7. Write out the whole query in `query1.sql` and add a LIMIT of 10:  
    ```
    SELECT cadet.id, cadet.name, cadet.callsign, award.name  
    FROM cadet, LEFT OUTER JOIN award ON award.cadet_id = cadet.id  
    WHERE cadet.name IS NOT NULL  
    ORDER BY cadet.name
    LIMIT 10;  
    ```
  8. Open the join2.db and load `query1.sql` then review the results.
    ```
    $ sqlite3 join2.db
    sqlite> .read query1.sql
    ```
2. **Show the first 10 battles by Dragon Army, and if Andrew Wiggin fought in them, show his battle info.**
  1. Decide which table to select FROM, and which table to LEFT JOIN.  
    `battle`, `cadet_battle`, and `cadet`
  2. Make sure you place the table with potential NULL columns on the Right.  
    `cadet_battle` may not have rows for every `battle`, and we only care about the statistics of one particular `cadet`.
  3. Remember to use the ON or USING keywords to specify the conditions for the LEFT JOIN. 
    `FROM battle, LEFT OUTER JOIN cadet_battle ON cadet_battle.battle_id = battle.id, JOIN cadet ON cadet.id = cadet_battle.cadet_id` 
  4. Specify the WHERE clause(s).  
    `WHERE army1_id = 1 OR army2_id = 1 AND cadet_battle.cadet_id = 1` i.e. show battles by Dragon Army and with cadet Andrew Wiggin
  5. Decide which field(s) to SELECT. 
    `SELECT battle.id, battle.date, battle.winner, cadet.name, cadet_battle.frozen, cadet_battle.num_frozen, cadet_battle.frozen_by, cadet_battle.shots, cadet_battle.toon_id, cadet_battle.mvp`  
  6. Decide which field(s) to ORDER BY.  
    `ORDER BY battle.date`
  7. Write out the whole query in `query2.sql` and add a LIMIT of 10:  
  
    ```
    SELECT battle.id, battle.date, battle.winner, cadet.name, cadet_battle.frozen, cadet_battle.num_frozen, cadet_battle.frozen_by, cadet_battle.shots, cadet_battle.toon_id, cadet_battle.mvp
    FROM battle, LEFT OUTER JOIN cadet_battle ON cadet_battle.battle_id = battle.id, JOIN cadet ON cadet.id = cadet_battle.cadet_id
    WHERE army1_id = 1 OR army2_id = 1 AND cadet_battle.cadet_id = 1  
    ORDER BY battle.date
    LIMIT 10;  
    ```
  8. Open the join2.db and load `query2.sql` then review the results.
    ```
    $ sqlite3 join2.db
    sqlite> .read query2.sql
    ```
    
##Syntax review

1. Decide which table to select FROM, and which table to LEFT JOIN.
2. Make sure you place the table with potential NULL columns on the Right.
3. Remember to use the ON or USING keywords to specify the conditions for the LEFT JOIN.
4. Specify the WHERE clause(s).
5. Decide which field(s) to SELECT.
6. Decide which field(s) to ORDER BY.
7. Add a LIMIT.


##Code challenge

Edit `query3.sql` and `query4.sql` files, and write a query to find the following:

1. Show a list of cadets who fought in battle 18 and their hit statistics, if any.
2. Show a list of all armies and any battles they fought in the week of December 5th, 2032.