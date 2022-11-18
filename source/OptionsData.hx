package;

import flixel.FlxG;

using StringTools;

class OptionsData 
{
    // Version Game
    public static var engineVer:String = "0.1.0";

    // Data Game
    public static var newInput:Bool;
    public static var downscroll:Bool;
    public static var accuracy:Bool;
    public static var botplay:Bool;
    public static var dfjk:Bool;
    public static var splash:Bool;
    public static var practice:Bool;
    public static var middlescroll:Bool;
    public static var scoreColor:Bool;
    public static var disable_popUP:Bool;
    public static var scoreTween:Bool;
    
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

        if (FlxG.save.data.splash == null)
			FlxG.save.data.splash = true;

        if (FlxG.save.data.practice == null)
			FlxG.save.data.practice = false;

        if (FlxG.save.data.middlescroll == null)
            FlxG.save.data.middlescroll = false;

        if (FlxG.save.data.scoreColor == null)
            FlxG.save.data.scoreColor = true;

        if (FlxG.save.data.disable_popUP == null)
			FlxG.save.data.disable_popUP = false;

        if (FlxG.save.data.scoreTween == null)
            FlxG.save.data.scoreTween = true;

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
        FlxG.save.data.splash = splash;
        FlxG.save.data.practice = practice;
        FlxG.save.data.middlescroll = middlescroll;
        FlxG.save.data.scoreColor = scoreColor;
        FlxG.save.data.disable_popUP = disable_popUP;
        FlxG.save.data.scoreTween = scoreTween;

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
        OptionsData.splash = FlxG.save.data.splash;
        OptionsData.practice = FlxG.save.data.practice;
        OptionsData.middlescroll = FlxG.save.data.middlescroll;
        OptionsData.scoreColor = FlxG.save.data.scoreColor;
        OptionsData.disable_popUP = FlxG.save.data.disable_popUP;
        OptionsData.scoreTween = FlxG.save.data.scoreTween;

        FlxG.save.flush();
        FlxG.save.bind('funkin', 'ninjamuffin99');
    }
}