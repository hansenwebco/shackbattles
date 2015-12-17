# ShackBattles
ShackBattles is partner site for ShackNews.com which allows users to schedule and advertise online multiplayer game events.  

## What You Need to Develop
The site is written in .NET 4.5 using Web Forms, the Entity Framework, and SQL Server 2012.

To develop you will need to have a minimum of the following installed.

* Visual Studio 2013  (Express should work)
* SQL Server Express 2012 or Greater

## Setting Up

There is very little in the way of configration, pull down the latest branch, build and NuGet should grab any packages releated to the project.

1. The database can be created either via the Entity Framework Model ( /data/SBModel.edmx ) by opening and then right clicking and selecting "Generate Database from Model".  You may also run the schema.sql also located in the /data folder, although it might not always be as up to date.  

2. You will need to update the **PrivateConnectionStrings.config** and **PrivateSettings.config** in the root of the project.  PrivateConnectionStrings.config should point to database instance you have created.  The PrivateSettings.config should be updated with the account used to send ShackMessages on ShackNews.com.  

   **NOTE:**  You should mark the .config files above as "assume-unchanged" in Git by executing this command in the Git command line.

   > update-index --assume-unchanged c:\path-to-file\PrivateSettings.config

   This should prevent accidental commits with your database and shack account information.

3. Finally you'll need to give IIS write permissions on the /images/boxart folder in order to download images when adding games to your database, if you don't do this you'll get a placeholder image instead.

## Starting Data

The project should run but you may want to setup your GameSystems table to match the live site in which case the default data is      currently:

### dbo.GameSystem

|GameSystemKey	|GameSystemName|	GameDBPlatformID|
|:----:|----|----|
|1|	Xbox One|	Microsoft Xbox One|
2|	Xbox 360|	Microsoft xbox 360|
3|	Playstation 3|	Sony Playstation 3|
4|	Playstation 4	|Sony Playstation 4|
5|	PC|	PC|

