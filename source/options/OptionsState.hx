package options;

import flixel.graphics.FlxGraphic;
import openfl.display.Sprite;
import states.MainMenuState;
import backend.StageData;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics','Fps','HealthBar' , 'TimeBar', 'Visuals and Music','Camera' ,'Gameplay'];
    private var grpOptions:FlxTypedGroup<Alphabet>;
	private var grpSpritesOptions:FlxTypedSpriteGroup<FlxSprite>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	var opcionSprite:FlxSprite;


	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Fps':
				openSubState(new options.FpsSettingsState());
			case 'HealthBar':
				openSubState(new options.HealthBarSettingsState());
			case 'TimeBar':
				openSubState(new options.TimeBarSettingsState());
			case 'Visuals and Music':
				openSubState(new options.VisualsMusicSubState());
			case 'Camera':
				openSubState(new options.CameraSettingsState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG/menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xffff6701;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		grpSpritesOptions = new FlxTypedSpriteGroup<FlxSprite>();
		add(grpSpritesOptions);


   /*     for (i in 0...options.length) {
            var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
            optionText.screenCenter();
            optionText.x += (0);
			optionText.y += (-230);
            grpOptions.add(optionText);
      }*/

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

        for (i in 0...options.length) {

			var optionSprite:FlxSprite = new FlxSprite(300, 0).loadGraphic(Paths.image('opcionMenu/' + (options[i] + (ClientPrefs.data.Lenguage == 'Español' ? '_spanish' : ''))));
 			 optionSprite.scale.x = 0.3;
			 optionSprite.scale.y = 0.3;
           	 optionSprite.screenCenter();
             optionSprite.x += (0);
			 optionSprite.y += (0);
           	 grpSpritesOptions.add(optionSprite);
        }

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_LEFT_P) {
			changeSelection(-1);
		}
		if (controls.UI_RIGHT_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
		else if (FlxG.mouse.justPressed) openSelectedSubstate(options[curSelected]);
	}
	
    function changeSelection(change:Int = 0) {
        curSelected += change;
        if (curSelected < 0)
            curSelected = options.length - 1;
        if (curSelected >= options.length)
            curSelected = 0;

        var bullShit:Int = 0;

      /*  for (item in grpOptions.members) {
            item.targetY = bullShit - curSelected;
            bullShit++;

			item.alpha = 0;
            if (item.targetY == 0) { // Change targetY to targetX
                item.alpha = 1;
                selectorLeft.x = item.x + -30;
                selectorLeft.y = item.y; 
                selectorRight.x = item.x + item.width;
                selectorRight.y = item.y;
            }
        }*/

		for (i in 0...grpSpritesOptions.members.length) {
			var item:FlxSprite = grpSpritesOptions.members[i];
		
			var newY:Float = bullShit - curSelected;
			bullShit++;
		
			if (i == curSelected) {
				item.alpha = 1;
				selectorLeft.x = item.x + -50;
                selectorLeft.y = item.y; 
                selectorRight.x = item.x + item.width;
                selectorRight.y = item.y;
			} else {
				item.alpha = 0;
			}
		}	
				
		FlxG.sound.play(Paths.sound('scrollMenu'));
		
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}