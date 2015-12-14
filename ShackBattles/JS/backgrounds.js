function background(img, gameTitle, gameDev, gameYear)
{
    this.img = img;
    this.gameTitle = gameTitle;
    this.gameDev = gameDev;
    this.gameYear = gameYear; 
}

var backgrounds = new Array();
backgrounds[1] = new background("back1.jpg", "Battlefield 1942", "Dice", "1982");
backgrounds[2] = new background("back2.jpg", "Unreal Tournament 3", "Epic Games", "2007");
backgrounds[3] = new background("back3.jpg", "Quake III Arena", "id Software", "1999");
backgrounds[4] = new background("back4.jpg", "Team Fortress 2", "Valve Corporation", "2007");
backgrounds[5] = new background("back5.jpg", "Battlefield 2: Armored Fury", "Dice Canada", "2006");
backgrounds[6] = new background("back6.jpg", "Call of Duty", "Infinity Ward", "2009");
backgrounds[7] = new background("back7.jpg", "Star Wars: Battlefront", "Pandemic Studios", "2004");
backgrounds[8] = new background("back8.jpg", "Halo 3", "Bungie", "2007");
backgrounds[9] = new background("back9.jpg", "Call of Duty: Modern Warfare 3", "Infinity Ward", "2011");
backgrounds[10] = new background("back10.jpg", "Borderlands 2", "Gearbox Software", "2012");
backgrounds[11] = new background("back11.jpg", "Battlefield 2142", "EA DICE", "2006");