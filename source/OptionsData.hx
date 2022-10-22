package;

import flixel.FlxG;

using StringTools;

class OptionsData 
{
    // Version Game
    public static var engineVer:String = "0.0.1";

    // Data Game
    public static var newInput:Bool;
    public static var downscroll:Bool;
    public static var accuracy:Bool;
    public static var botplay:Bool;
    public static var dfjk:Bool;
    // public static var npsTxt:Bool;
    
    static function gameData():Void 
    {
        if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.dfjk == null)
			FlxG.save.data.dfjk = false;
		
		if (FlxG.save.data.accuracyDisplay == null)
			FlxG.save.data.accuracyDisplay = true;

        if (FlxG.save.data.botplay == null)
			FlxG.save.data.botplay = false;

        // if (FlxG.save.data.npsTxt == null)
		// 	FlxG.save.data.npsTxt = false;

        saveData();

        FlxG.save.flush();
    }

    static public function loadData():Void 
    {
        FlxG.save.data.newInput = newInput;
        FlxG.save.data.downscroll = downscroll;
        FlxG.save.data.accuracyDisplay = accuracy;
        FlxG.save.data.botplay = botplay;
        FlxG.save.data.dfjk = dfjk;
        // FlxG.save.data.npsTxt = npsTxt;

        FlxG.save.flush();
        FlxG.save.bind('funkin', 'ninjamuffin99');
        
        saveData();
    }

    static public function saveData():Void
    {
        OptionsData.newInput = FlxG.save.data.newInput;
        OptionsData.downscroll = FlxG.save.data.downscroll;
        OptionsData.accuracy = FlxG.save.data.accuracyDisplay;
        OptionsData.botplay = FlxG.save.data.botplay;
        OptionsData.dfjk = FlxG.save.data.dfjk;
        // OptionsData.npsTxt = FlxG.save.data.npsTxt;

        FlxG.save.flush();
        FlxG.save.bind('funkin', 'ninjamuffin99');
    }
}