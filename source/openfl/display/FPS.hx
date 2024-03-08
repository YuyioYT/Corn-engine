package openfl.display;

import openfl.text.TextFormatAlign;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

#if openfl
import openfl.system.System;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;
	public var currentlyFPS(default, null):Int;
	public var totalFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public var currentlyMemory:Float;
	public var maximumMemory:Float;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;

		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	var array:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0, 0)
	];

	var skippedFrames = 0;

	var fontSize = 14;

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		var color:Int = 0xFFFFFF;
        var font:String = "_sans";

		var currentCount = times.length;
		currentlyFPS = Math.round((currentCount + cacheCount) / 2);
		totalFPS = Math.round(currentlyFPS + currentCount / 8);
		if (currentlyFPS > ClientPrefs.data.framerate)
			currentlyFPS = ClientPrefs.data.framerate;
		if (totalFPS < 10)
			totalFPS = 0;

		if (currentCount != cacheCount) {
			text = "FPS: " + currentlyFPS;

			currentlyMemory = obtainMemory();
			if (currentlyMemory >= maximumMemory)
				maximumMemory = currentlyMemory;
		}
		
        if (ClientPrefs.data.FpsType == 'Psych') {
            font = "_sans";
			if (ClientPrefs.data.fpssize == '1')
			{
				fontSize = 14;
			}else if (ClientPrefs.data.fpssize == '-1')
			{
				fontSize = 14 - 5;
			}else if (ClientPrefs.data.fpssize == '2')
			{
				fontSize = 14 + 5;
			}else if (ClientPrefs.data.fpssize == '3')
			{
				fontSize = 14 + 10;
			}
        } else if (ClientPrefs.data.FpsType == 'Original') {
            font = "_sans";
			if (ClientPrefs.data.fpssize == '1')
			{
				fontSize = 10;
			}else if (ClientPrefs.data.fpssize == '-1')
			{
				fontSize = 10 - 5;
			}else if (ClientPrefs.data.fpssize == '2')
			{
				fontSize = 10 + 5;
			}else if (ClientPrefs.data.fpssize == '3')
			{
				fontSize = 10 + 10;
			}
        } else if (ClientPrefs.data.FpsType == 'Dave engine') {
            font = "Comic Sans MS Bold";
			if (ClientPrefs.data.fpssize == '1')
			{
				fontSize = 14;
			}else if (ClientPrefs.data.fpssize == '-1')
			{
				fontSize = 14 - 5;
			}else if (ClientPrefs.data.fpssize == '2')
			{
				fontSize = 14 + 5;
			}else if (ClientPrefs.data.fpssize == '3')
			{
				fontSize = 14 + 10;
			}
        } else if (ClientPrefs.data.FpsType == 'Purgatory old') {
			font = "VCR OSD Mono";
			if (ClientPrefs.data.fpssize == '1')
			{
				fontSize = 14;
			}else if (ClientPrefs.data.fpssize == '-1')
			{
				fontSize = 14 - 5;
			}else if (ClientPrefs.data.fpssize == '2')
			{
				fontSize = 14 + 5;
			}else if (ClientPrefs.data.fpssize == '3')
			{
				fontSize = 14 + 10;
			}
		}

	/*	if (ClientPrefs.data.memory) {
			text += "\nMemory: " + CoolUtil.formatMemory(Std.int(currentlyMemory));
		}*/
        var textFormat:TextFormat = new TextFormat(font, fontSize, color);
        textFormat.align = TextFormatAlign.LEFT;

        defaultTextFormat = textFormat;
        setTextFormat(textFormat);

		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		if (ClientPrefs.data.rainbowFPS) {
			if (textColor >= array.length)
				textColor = 0;
			textColor = Math.round(FlxMath.lerp(0, array.length, skippedFrames / (ClientPrefs.data.framerate / 3)));
			(cast(Lib.current.getChildAt(0), Main)).changeFPSColor(array[textColor]);
			textColor++;
			skippedFrames++;
			if (skippedFrames > (ClientPrefs.data.framerate / 3))
				skippedFrames = 0;
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > ClientPrefs.data.framerate) currentFPS = ClientPrefs.data.framerate;

		if (currentCount != cacheCount /*&& visible*/)
		{
			text = "FPS: " + currentFPS;
			var memoryMegas:Float = 0;
			
			#if openfl
			if (ClientPrefs.data.memory){
			memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
			text += "\nMemory: " + memoryMegas + " MB";
			}
			var memoryMegas:Float = 0;
			if (ClientPrefs.data.memoryGB){
			memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
			var memoryGB = (memoryMegas / 1000);
			text += "\nMemory: " + FlxMath.roundDecimal(memoryGB, 2) + " GB";
			}

			if (ClientPrefs.data.totalMemory) {
				text += "\nMemory peak: " + CoolUtil.formatMemory(Std.int(maximumMemory));
			}
	
			if (ClientPrefs.data.engineVersion) {
				text += "\nCorn engine v" + states.MainMenuState.cornEngineVersion + " (Psych Engine v" + states.MainMenuState.psychEngineVersion + ")";
			}
			if (ClientPrefs.data.totalFPS) {
				text += "\nTotal FPS: " + totalFPS;
			}

			textColor = 0xFFFFFFFF;
			if (memoryMegas > 3000 || currentFPS <= ClientPrefs.data.framerate / 2)
			{
				textColor = 0xFFFF0000;
			}
			#end

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end

			text += "\n";
		}

		cacheCount = currentCount;
	}

	function obtainMemory():Dynamic {
		return System.totalMemory;
	}
}
