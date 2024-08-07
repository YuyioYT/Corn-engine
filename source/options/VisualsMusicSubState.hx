package options;

import objects.Note;
import objects.StrumNote;
import objects.Alphabet;

class VisualsMusicSubState extends BaseOptionsMenu
{
	var noteOptionID:Int = -1;
	var notes:FlxTypedGroup<StrumNote>;
	var notesTween:Array<FlxTween> = [];
	var noteY:Float = 90;
	public function new()
	{
		title = 'Visuals and Music';
		rpcTitle = 'Visuals & Music Settings Menu'; //for Discord Rich Presence

		// for note skins
		notes = new FlxTypedGroup<StrumNote>();
		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = new StrumNote(370 + (560 / Note.colArray.length) * i, -200, i, 0);
			note.centerOffsets();
			note.centerOrigin();
			note.playAnim('static');
			notes.add(note);
		}

		// options

		var noteSkins:Array<String> = Mods.mergeAllTextsNamed('images/noteSkins/list.txt', 'shared');
		if(noteSkins.length > 0)
		{
			if(!noteSkins.contains(ClientPrefs.data.noteSkin))
				ClientPrefs.data.noteSkin = ClientPrefs.defaultData.noteSkin; //Reset to default if saved noteskin couldnt be found

			noteSkins.insert(0, ClientPrefs.defaultData.noteSkin); //Default skin always comes first
			var option:Option = new Option('Note Skins:',
				"Select your prefered Note skin.",
				'noteSkin',
				'string',
				noteSkins);
			addOption(option);
			option.onChange = onChangeNoteSkin;
			noteOptionID = optionsArray.length - 1;
		}
		
		var noteSplashes:Array<String> = Mods.mergeAllTextsNamed('images/noteSplashes/list.txt', 'shared');
		if(noteSplashes.length > 0)
		{
			if(!noteSplashes.contains(ClientPrefs.data.splashSkin))
				ClientPrefs.data.splashSkin = ClientPrefs.defaultData.splashSkin; //Reset to default if saved splashskin couldnt be found

			noteSplashes.insert(0, ClientPrefs.defaultData.splashSkin); //Default skin always comes first
			var option:Option = new Option('Note Splashes:',
				"Select your prefered Note Splash variation or turn it off.",
				'splashSkin',
				'string',
				noteSplashes);
			addOption(option);
		}

		var option:Option = new Option('Note Splash Opacity',
			'How much transparent should the Note Splashes be.',
			'splashAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Show MS Popup',
		"If checked, hitting a note will also show how late/early you hit it.",
		'showMS',
		'bool');
		addOption(option);

		var option:Option = new Option('Hide HUD',
		'If checked, hides most HUD elements.',
		'hideHud',
		'bool');
		addOption(option);

		var option:Option = new Option('Hide Judgements',
		'his name say all',
		'hideJudgements',
		'bool');
		addOption(option);

		var option:Option = new Option('Combo Judgement text',
		'Combo judgement text',
		'hideCombo',
		'bool');
		addOption(option);

		var option:Option = new Option('Nps Judgement text',
		'Nps judgement text',
		'hideNps',
		'bool');
		addOption(option);

		var option:Option = new Option('Nps Max Judgement text',
		'Nps Max judgement text',
		'hideMaxNps',
		'bool');
		addOption(option);

		var option:Option = new Option('Total Notes Judgement text',
		'Total Notes judgement text',
		'hidetotalNotes',
		'bool');
		addOption(option);

		var option:Option = new Option('Combo Breaks Judgement text',
		'Combo Breaks judgement text',
		'hideComboBreaks',
		'bool');
		addOption(option);

		var option:Option = new Option('Misses Judgement text',
		'Misses judgement text',
		'hideMisses',
		'bool');
		addOption(option);

		var option:Option = new Option('Ratings On Cam Game',
		'Ratings On Cam Game',
		'RatingsOnGame',
		'bool');
		addOption(option);

		var option:Option = new Option('Spin on start',
		'Spin on start',
		'SpinonStart',
		'bool');
		addOption(option);

		var option:Option = new Option('Song Watermark',
		'his name say all',
		'songWatermark',
		'bool');
		addOption(option);

		var option:Option = new Option('Remove Perfect',
		'his name say all',
		'removePerfs',
		'bool');
		addOption(option);

		var option:Option = new Option('Icon change on freeplay',
		'Very cool icon change',
		'iconChangeonFreeplay',
		'bool');
		addOption(option);

		var option:Option = new Option('Typografy in the texts:',
		"Typografy",
		'Typografy',
		'string',
		['VCR', 'Comic-sans']);
		addOption(option);

		var option:Option = new Option('Lenguage:',
		"Lenguage traduction",
		'Lenguage',
		'string',
		['English', 'Español']);
		addOption(option);
		
		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool');
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool');
		addOption(option);

		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool');
		addOption(option);
		#end

		#if desktop
		var option:Option = new Option('Discord Rich Presence',
			"Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord",
			'discordRPC',
			'bool');
		addOption(option);
		#end

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool');
		addOption(option);

		var option:Option = new Option('Combo Sprite',
		"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
		'ComboSprite',
		'bool');
		addOption(option);

		super();
		add(notes);
	}

	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);
		
		if(noteOptionID < 0) return;

		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = notes.members[i];
			if(notesTween[i] != null) notesTween[i].cancel();
			if(curSelected == noteOptionID)
				notesTween[i] = FlxTween.tween(note, {y: noteY}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
			else
				notesTween[i] = FlxTween.tween(note, {y: -200}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}

	function onChangeNoteSkin()
	{
		notes.forEachAlive(function(note:StrumNote) {
			changeNoteSkin(note);
			note.centerOffsets();
			note.centerOrigin();
		});
	}

	function changeNoteSkin(note:StrumNote)
	{
		var skin:String = Note.defaultNoteSkin;
		var customSkin:String = skin + Note.getNoteSkinPostfix();
		if(Paths.fileExists('images/$customSkin.png', IMAGE)) skin = customSkin;

		note.texture = skin; //Load texture and anims
		note.reloadNote();
		note.playAnim('static');
	}

	override function destroy()
	{
		if(changedMusic && !OptionsState.onPlayState) FlxG.sound.playMusic(Paths.music('MenuMusic'), 1, true);
		super.destroy();
	}
}
