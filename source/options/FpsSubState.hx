package options;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class FpsSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [''];
	
    var curSelected:Int = 0;

	var pauseMusic:FlxSound;

    var titleText:FlxText;
	var fpsText:FlxText;

	var FPS:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.optionsTxt('fps')));

    var transIn = FlxTransitionableState.defaultTransIn;
    var transOut = FlxTransitionableState.defaultTransOut;

	public function new():Void
	{
		super();

		// FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

        fpsText = new FlxText(0,0,0,"FPS: " + Std.string(FPS), 18);
        // fpsText.alpha = 0;
		fpsText.scrollFactor.set();
        fpsText.screenCenter();
        add(fpsText);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});

		// changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        if (controls.BACK){
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
            FlxG.state.closeSubState();
            FlxG.switchState(new OptionsMenu());
        }

        if (controls.LEFT_P){
            FPS -= 10;
            sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
            FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
            FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));       
        }

        if (controls.RIGHT_P){
            FPS += 10;
            sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
            FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
            FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));       
        }
	}
}
