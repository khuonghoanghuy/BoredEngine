package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;
	var fpsText:FlxText;

	var FPS:Int = Std.parseInt(CoolUtil.coolTextFileString(Paths.optionsTxt('fps')));

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		controlsStrings = CoolUtil.coolStringFile(
			(OptionsData.dfjk ? 'DFJK' : 'WASD') +
			"\n" + (OptionsData.newInput ? "New input" : "Old Input") + 
			"\n" + (OptionsData.downscroll ? 'Downscroll' : 'Upscroll') +
			"\nAccuracy " + (OptionsData.accuracy ? "on" : "off") +
			"\nBotplay " + (OptionsData.botplay ? "on" : "off") +
			"\nNps Text " + (OptionsData.npsTxt ? "on" : "off")
		);
		
		trace(controlsStrings);

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		versionShit = new FlxText(5, FlxG.height - 18, 0, "Offset (Left, Right): " + FlxG.save.data.offset, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		fpsText = new FlxText(5, FlxG.height - 36, 0, "FPS (Press F key to setting the FPS) ", 12);
		fpsText.scrollFactor.set();
		fpsText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fpsText);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);

			if (FlxG.keys.justPressed.F){
				openSubState(new options.FpsSubState());
			}

			if (controls.RIGHT_R)
			{
				FlxG.save.data.offset++;
				versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
			}

			if (controls.LEFT_R)
			{
				FlxG.save.data.offset--;
				versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
			}
	
			if (controls.ACCEPT)
			{
				grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						OptionsData.dfjk = !OptionsData.dfjk;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (OptionsData.dfjk ? 'DFJK' : 'WASD'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
						if (OptionsData.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
						
					case 1:
						OptionsData.newInput = !OptionsData.newInput;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (OptionsData.newInput ? "New input" : "Old Input"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);				
					case 2:
						OptionsData.downscroll = !OptionsData.downscroll;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (OptionsData.downscroll ? 'Downscroll' : 'Upscroll'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
					case 3:
						OptionsData.accuracy = !OptionsData.accuracy;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Accuracy " + (OptionsData.accuracy ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
					case 4:
						OptionsData.botplay = !OptionsData.botplay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Botplay " + (OptionsData.botplay ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 4;
						grpControls.add(ctrl);
					case 5:
						OptionsData.npsTxt = !OptionsData.npsTxt;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Nps Text " + (OptionsData.npsTxt ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 5;
						grpControls.add(ctrl);
				}
			}
		FlxG.save.flush();
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
