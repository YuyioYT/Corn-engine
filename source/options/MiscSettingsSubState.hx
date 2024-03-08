package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import backend.Controls;

using StringTools;

class MiscSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Miscellaneous';
		rpcTitle = 'Miscellaneous Settings Menu'; //for Discord Rich Presence

		//var option:Option = new Option('Icon Bops:',
		//	"What type should icon bopping be?",
		//	'iconBop',
		//	'string',
		//	'Unknown',
		///	['Unknown', 'Psych', 'PFNF', 'OS', 'Modern']);
		//addOption(option);
		
		//var option:Option = new Option('Icon Type:',
		//	"What type should the icons be?",
		//	'iconVer',
		//	'string',
		//	'MU + Vanilla (Default)',
		//	['MU + Vanilla (Default)', 'Mic\'d Up', 'Vanilla']);
		//addOption(option);
		
		//var option:Option = new Option('Menu Theme:',
	//		'What theme should the menu be?',
		//	'menuTheme',
		//	'string',
		//	'Light',
		//	['Light', 'Dark', 'Vanilla', 'Time of Day']);
		//addOption(option);
		
		//var option:Option = new Option('Language:',
		//	'Choose a language to pick.',
		//	'langOption',
		//	'string',
		////	'English',
		//	['English', 'French', 'Portuguese']);
		//addOption(option);
		
		/*var option:Option = new Option('BF Version:',
			"What BF should be used in gameplay?",
			'bfAltVersion',
			'string',
			'Zero',
			['Normal', 'ZERO', 'TzenZoule']);
		addOption(option);
		option.showBoyfriend = true;
		option.onChange = onChangeBoyfriendOption;
*/
		
		var option:Option = new Option('Color Filters:',
			"Change how colors of the game work, either for fun or if you're colorblind.",
			'colorblindMode',
			'string',
			'None', 
			['None', 'Deuteranopia', 'Protanopia', 'Tritanopia']);
		option.onChange = shaders.ColorblindFilters.applyFiltersOnGame;
		addOption(option);
		
		//var option:Option = new Option('ProjectFNF Modifiers',
		//	"",
		//	'',
		//	'string',
		//	'', 
		//	['']);
		//addOption(option);
	/*	
		var option:Option = new Option('Damage from Opponent Notes', // Name
			'How much health will the opponent reduce by hitting a note', // Description
			'damageFromOpponentNotes', // Save data variable name
			'float', // Variable type
			0); // Default value
		option.displayFormat = "%v%";
		option.scrollSpeed = 3.3;
		option.minValue = 0.0;
		option.maxValue = 10.0;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Opponent Notes Can Kill', // Name
			'If checked, damage from opponent notes can be lethal.', // Description
			'opponentNotesCanKill', // Save data variable name
			'bool', // Variable type
			false); // Default value
		addOption(option);
		super();
	}
//
	/*
	function onChangeBoyfriendOption()
	{
		for (sprite in members)
		{
			var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
			var sprite:FlxSprite = sprite; //Don't judge me ok
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				if (ClientPrefs.bfAltVersion == 'Normal') sprite.loadGraphic('characters/BOYFRIEND', true);
				if (ClientPrefs.bfAltVersion == 'ZERO') sprite.loadGraphic('characters/BOYFRIEND-ZERO', true);
				if (ClientPrefs.bfAltVersion == 'Reanimated') sprite.loadGraphic('characters/BOYFRIEND', true);
			}
		*///	}
	}

}