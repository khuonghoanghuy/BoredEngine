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
    var versionShit:FlxText;

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

        titleText = new FlxText(0,30,0,"FPS Setting",30);
        titleText.screenCenter(X);
        titleText.scrollFactor.set();
        titleText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(titleText);

        fpsText = new FlxText(0,100,0,"FPS: " + Std.string(FPS), 30);
        // fpsText.alpha = 0;
        fpsText.screenCenter(X);
        fpsText.scrollFactor.set();
        fpsText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(fpsText);

        versionShit = new FlxText(5, FlxG.height - 18, 0, "Press Esc to return options | Press Left to -10 FPS | Press Right to +10 FPS", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});

		// changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        if (controls.BACK){
			// FlxTransitionableState.skipNextTransIn = true;
			// FlxTransitionableState.skipNextTransOut = true;
            // FlxG.state.closeSubState();
            FlxG.switchState(new OptionsMenu());
            sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
            FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
            FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));    
        }

        fpsText.text = "FPS: " + Std.string(FPS);

        if (controls.LEFT_R && FPS >= 70){
            FPS -= 10;
            sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
            FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
            FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));       
        }

        if (controls.RIGHT_R){
            FPS += 10;
            sys.io.File.saveContent(Paths.txt('options/fps'), Std.string(FPS));
            FlxG.updateFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));
            FlxG.drawFramerate = Std.parseInt(CoolUtil.coolTextFileString(Paths.txt('options/fps')));       
        }
	}
}
