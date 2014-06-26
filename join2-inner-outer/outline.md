Joins: Inner vs. Outer Joins
============================

Welcome to Part 2 of the lesson on database joins with SQL. This lesson builds on the previous lesson about joins, introducing the Outer Join concept. The database uses a "Battle School" as the example.

#Overview

1. What is an Outer Join for?
2. Live demo
3. Syntax review
4. Code challenge

##What is an Outer Join for?

Let's talk again about the Principle of *Normalization*. In our last example, we say how a Join can bring our data back together after we split it into tables using Normalization. One reason for Normalization is so we don't have bunches of NULL columns in rows where that information is not relevant. However, when we join tables together, there is more than one way to do that.

If you look at a Venn Diagram of two tables A and B using the default Join, or *Inner Join*,  you see that the default join only shows data where the two circles overlap.

What this means is that the table on the left may have lots of rows that match our WHERE clause, but the conditions of the Inner Join are preventing them from being returned. That's where the *Outer Join* comes in. The Outer Join allows us to include matching rows from the table on the left, without a corresponding row on the right. That's why an Outer join can also be referred to as a *Left Join*.

* Show all of A, and include B if it exists, matching on a condition.  
  *e.g. "Show a list of all cadets and awards they have won, if any."*
* Inner Joins include just those rows that match. Even if some rows from table A meet the criteria, an Inner Join would not include them unless there is a corresponding row in table B.  
  *e.g. an Inner Join would ONLY show cadets who have won awards*
* Outer Joins include all matching rows from the table on the Left; a match on the Right is not needed.  
  *i.e. All cadets will be shown, their awards only appear if they exist.*
* If there are no NULL values on the key to the join, there will be no difference between Inner and Outer Join.
* The most common type of Outer Join is a Left Join. SQLite only implements a Left Outer Join.
* You may use `LEFT JOIN` and `LEFT OUTER JOIN` interchangeably in SQLite.  
* The Left and Right tables in Inner Joins can be reordered without affecting the results, but for Outer Joins the ordering of the tables matters.  
  *i.e. Placing awards on the Left would mean all awards were included, not all Cadets.*
* In a Left join, you want to use the ON or USING syntax. If you use WHERE, you may omit rows.  
  *i.e. If a row in the `award` table is NULL, its `cadet_id` cannot be equal to an `id` in the `cadet` table.*

##Live demo

In this section, we will re-visit our systematic approach to writing queries, adding a rule for Outer Joins.

1. Open the `join2.db` from the folder `join2-outer-inner`.  
  `$ cd join2-outer-inner`  
  `$ sqlite3 join2.db`
2. List the available tables, and get a schema description for the `cadet` and `award` table.
  `sqlite3> .tables`
  `sqlite3> .schema cadet`
  `sqlite3> .schema award`
3. Plan your queries.

Remember that we have a system for writing a query: choose the tables (including the joins), the WHERE clause, the fields to SELECT, the ORDER BY and a LIMIT.

When doing an Outer Join, we need to remember to use the ON condition when we specify a table to join.

Here are two example queries broken down in this manner:

1. **Show a list of cadets and awards they have won, if any.**
  1. Decide which table to select FROM, and which table to LEFT JOIN.  
    `cadet` and `award`
  2. Make sure you place the table with potential NULL columns on the Right.  
    `award` may not have rows for every `cadet`, or may have multiple matches for one `cadet`.
  3. Remember to use the ON or USING keywords to specify the conditions for the LEFT JOIN. 
    `FROM cadet, LEFT OUTER JOIN award ON award.cadet_id = cadet.cadet_id` 
  4. Specify the WHERE clause(s).  
    `WHERE cadet.name IS NOT NULL` i.e. show all Cadets
  5. Decide which field(s) to SELECT. 
    `SELECT cadet.cadet_id, cadet.name, cadet.callsign, award.name`  
  6. Decide which field(s) to ORDER BY.  
    `ORDER BY cadet.name`
  7. Write out the whole query in `query1.sql` and add a LIMIT of 20:  
    ```
    SELECT cadet.cadet_id, cadet.name, cadet.callsign, award.name  
    FROM cadet LEFT OUTER JOIN award ON award.cadet_id = cadet.cadet_id  
    WHERE cadet.name IS NOT NULL  
    ORDER BY cadet.name
    LIMIT 20;
    ```
  8. Open the join2.db and load `query1.sql` then review the results.
    ```
    $ sqlite3 join2.db
    sqlite> .read query1.sql
    ```
2. **Show a list of cadets and the names of cadets who froze them in battle.**
  1. Decide which table to select FROM, and which table to LEFT JOIN.  
    `cadet`, `cadet_battle`, and `cadet`  
    *We will need aliases to write this query*
  2. Make sure you place the table with potential NULL columns on the Right.  
    If there is a NULL in `frozen_by_id` there will be no match in `cadet` when we join, we must make sure this table uses LEFT OUTER JOIN.
  3. Remember to use the ON or USING keywords to specify the conditions for the LEFT JOIN. 
    `FROM cadet AS c1 JOIN cadet_battle AS cb ON cb.cadet_id = c1.cadet_id LEFT OUTER JOIN cadet AS c2 ON c2.cadet_id = cb.frozen_by_id` 
  4. Specify the WHERE clause(s).  
    `WHERE c1.name IS NOT NULL` i.e. show battles by Dragon Army and with cadet Andrew Wiggin
  5. Decide which field(s) to SELECT. 
    `SELECT c1.cadet_id, c1.name, c1.army_id, cb.battle_id, cb.hits_taken, c2.name, c2.army_id`  
  6. Decide which field(s) to ORDER BY.  
    `ORDER BY c1.army_id`
  7. Write out the whole query in `query2.sql` and add a LIMIT of 20:  
  
    ```
    SELECT c1.cadet_id, c1.name, c1.army_id, cb.battle_id, cb.hits_taken, c2.name, c2.army_id  
    FROM cadet AS c1 JOIN cadet_battle AS cb ON cb.cadet_id = c1.cadet_id LEFT JOIN cadet AS c2 ON c2.cadet_id = cb.frozen_by_id  
    WHERE c1.name IS NOT NULL  
    ORDER BY c1.army_id  
    LIMIT 20;
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

1. Show a list of cadets and their awards, and show the name and date of the battle it was awarded for, if any.
2. Show a list of cadets who fought in battles from September 4th to 11th, 2032 and the cadet who froze them, if any.

##Coming Up

In our next tutorial, we will cover the concept of GROUP BY and functions like COUNT() MIN() SUM() and AVG()