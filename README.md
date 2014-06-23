sql-battle-school
=================

Supplimental files for a SQL tutorial using SQLite. The database uses a "Battle School" from the novel "Ender's Game".

#What is SQL?

SQL stands for Structured Query Language.

Essentially, SQL is a standardized way of asking for information. Several database engines use the same language structure to describe, store, retrieve, and edit the data in a way that hides how the magic is actually happening. This means you don't need to worry about the hard parts, like memory and disk management, or the fastest way to sort through countless records, and you can just focus on the information you want.

For the first several chapters of this series, you will use SQLite, which runs on all major operating systems as a simple executable file, and reads ordinary files that hold the database schemas and data. It is much easier to install than any other RDBMS and it will serve to help us learn SQL syntax. If you already have access to a database sever, there are some commands that will work slightly differently. See the "SQLite Quirks" section below.

##Installing SQLite

SQLite is a lightweight, open source (public domain) database engine that has no server. Therefore, all you need is a copy of the sqlite3 executable and a database file to get started.

###Mac OS

1. SQLite should already be installed. Open Terminal.app and type `sqlite3`. _(To exit, type `.quit` on the `sqlite>` prompt.)_
2. If the `sqlite3` command is not found, download the [**Precompiled Binaries for Mac OS X (x86)**](http://www.sqlite.org/download.html#mac) from the SQLite site and get the command-line shell.
3. Unzip the file and place the binary in a common location, such as `~/bin/`.
4. Edit your .bash_profile to add this line: `export PATH="$PATH":~/bin`
5. Restart Terminal.app to make sure your new values for PATH are available.

###Windows

1. Visit the SQLite downloads page and find the section labeled [**Precompiled Binaries for Windows**](http://www.sqlite.org/download.html#win32) and get the command-line shell.
2. Unzip the sqlite3.exe into a common location, such as `%HOMEPATH%/bin`.
3. Add `%HOMEPATH%/bin` [to your PATH environment variable](http://msdn.microsoft.com/en-us/library/office/ee537574%28v=office.14%29.aspx).
4. Print the contents of your PATH to make sure your new /bin directory is found: `echo %PATH%`

###Linux

1. If sqlite3 is not already installed, use your package manager `sudo apt-get install sqlite3`

##SQLite Quirks

If you have ever used MySQL, PostgreSQL, MS-SQL or another database engine, you will learn that SQLite has some idiosyncrasies, as all database engines do. This [Comparison of different SQL implementations](http://troels.arvin.dk/db/rdbms/) can help you translate features between different databases if you are not using SQLite.



###SQL

`select, insert, update, delete, create table, drop table, alter table` all work as expected.

SQLite commands are terminated with a semicolon, **;**

###Running a particular Query _(SOURCE query1.sql, \i query1.sql)_

This is useful if you want to write and edit queries in a text editor.

`sqlite> .read query1.sql`

###Choosing an active database schema _(USE my-database, SET SCHEMA my-database)_

You may either give the file name to the database as an argument when opening the program, or use the `.open` command:
 
`bash$ sqlite3 my-database.db`

`sqlite> .open my-database.db`

###Get a list of tables _(SHOW TABLES, /dt, INFORMATION_SCHEMA TABLES)_

`sqlite> .tables`

`sqlite> .tables my%` (only show tables LIKE pattern 'my%')

###Get a table description _(DESCRIBE my-table, /d my-table, SP_HEPLP my-table)_

`sqlite> .schema my-table` (where my-table is the table being described)

`sqlite> .schema` (describe all tables)

###Exit the command line, Quit SQLite

`sqlite> .exit`

`sqlite> .quit`

###More commands

For a listing of the available dot commands, you can enter `.help` at any time.

`sqlite> .help`

Also view the [Command Line Shell For SQLite](http://www.sqlite.org/cli.html) guide.