# ShackBattles
ShackBattles is partner site for ShackNews.com which allows users to schedule and advertise online multiplayer game events.  

## What You Need to Develop
The site is written in .NET 4.5 using Web Forms, the Entity Framework, and SQL Server 2012.

To develop you will need to have a minimum of the following installed.

* Visual Studio 2013  (Express should work)
* SQL Server Express 2012 or Greater

## Setting Up

There is very little in the way of configration, pull down the latest branch, build and NuGet should grab any packages releated to the project.

The database can be created either via the Entity Framework Model ( /data/SBModel.edmx ) by opening and then right clicking and selecting "Generate Database from Model".  You may also run the schema.sql also located in the /data folder, although it might not always be as up to date.  T

You will need to update the **PrivateConnectionStrings.config** and **PrivateSettings.config** in the root of the project.  PrivateConnectionStrings.config should point to database instance you have created.  The PrivateSettings.config should be updated with the account used to send ShackMessages on ShackNews.com.  

Finally you'll need to give IIS write permissions on the /images/boxart folder in order to download images when adding games to your database, if you don't do this you'll get a placeholder image instead.

