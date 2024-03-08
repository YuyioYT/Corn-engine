package objects;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

    public static var framerate:Int = 12;

	public function new(char:String = 'bf', isPlayer:Bool = false, ?allowGPU:Bool = true)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char, allowGPU);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String, ?allowGPU:Bool = true) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			
            var isAnimated:Bool = char.endsWith('-animated'); // Verifica si el personaje está animado

            if (isAnimated)
            {
                var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/' + char);
                frames = file;

                antialiasing = ClientPrefs.data.antialiasing;

                if (char == 'bambigod2d-animated')
                {
                    animation.addByPrefix('Neutral', 'Neutral', framerate, true);
                    animation.addByPrefix('Defeat', 'Defeat', framerate, true);
                    animation.addByPrefix('Winning', 'Winning', framerate, true);
                    FlxTween.shake(this, 0.01 , 999999999 ,XY, { ease: FlxEase.linear });

                    framerate = 12;

                if (width == 450) {
                    iconOffsets[0] = (width - 150) / 3;
                    iconOffsets[1] = (width - 150) / 3;
                    iconOffsets[2] = (width - 150) / 3;
                } else {
                    iconOffsets[0] = (width - 150) / 2;
                    iconOffsets[1] = (width - 150) / 2;
                }

                    animation.play('Neutral',12);

                }

                if (char == 'god_expunged_1-animated')
                    {
                        FlxTween.shake(this, 0.01 , 999999999 ,XY, { ease: FlxEase.linear });
                    }
                
                framerate = 24;

                animation.addByPrefix('Neutral', 'Neutral', framerate, true);
                animation.addByPrefix('Defeat', 'Defeat', framerate, true);
                animation.addByPrefix('Winning', 'Winning',framerate, true);
                updateHitbox();

                if (width >= 300 && height >= 250)
                    {
                      scale.y = 0.5;
                      scale.x = 0.5;
                    }

                if (width == 450) {
                    iconOffsets[0] = (width - 150) / 3;
                    iconOffsets[1] = (width - 150) / 3;
                    iconOffsets[2] = (width - 150) / 3;
                } else {
                    iconOffsets[0] = (width - 150) / 2;
                    iconOffsets[1] = (width - 150) / 2;
                }

                updateHitbox();
            }
            else
            {
			    //var graphic = Paths.image(name, allowGPU);

                var file:Dynamic = Paths.image(name);

                loadGraphic(file);
                var width2 = width;

                if (width == 750) {
                    loadGraphic(file, true, Math.floor(width / 5), Math.floor(height));
                    iconOffsets[0] = (width - 150) / 5;
                    iconOffsets[1] = (width - 150) / 5;
                    iconOffsets[2] = (width - 150) / 5;
                    iconOffsets[3] = (width - 150) / 5;
                    iconOffsets[4] = (width - 150) / 5;
                } else if (width == 450) {
                    loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //Then load it fr // winning icons go br
                    iconOffsets[0] = (width - 150) / 3;
                    iconOffsets[1] = (width - 150) / 3;
                    iconOffsets[2] = (width - 150) / 3;
                } else {
                    loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr // winning icons go br
                    iconOffsets[0] = (width - 150) / 2;
                    iconOffsets[1] = (width - 150) / 2;
                }
                
                updateHitbox();
                if (width2 == 750) {
                    animation.add(char, [0, 1, 2, 3 , 4], 0, false, isPlayer);
                }
                else if (width2 == 450) {
                    animation.add(char, [0, 1, 2], 0, false, isPlayer);
                } else {
                    animation.add(char, [0, 1], 0, false, isPlayer);
                }
            }
                animation.play('Neutral');
			    animation.play(char);
			    this.char = char;

			    if(char.endsWith('-pixel')||char == '404'||char == 'god_expunged_1-animated'||char == 'hell1'||char == 'homo'||char == 'bambiGod'||char == 'bambiGod-2'||char == 'Godly_Goober_2-animated'||char == 'bambiGod3d'||char == 'bamburg_crazy'||char == '3drage'||char == 'bambi3dUnfair'||char == 'bombu'||char == 'crusturn'||char == 'crusti'||char == 'dataExpunged'||char == 'doubleee'||char == 'trueexpunged'||char == 'gary'||char == 'chaoscrimson-1'||char == 'bombuExpunged'||char == 'ohfuck')
				    antialiasing = false;
			    else
				    antialiasing = ClientPrefs.data.antialiasing;
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
