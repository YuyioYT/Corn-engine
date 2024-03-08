package options;

class FpsSettingsState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Fps';
		rpcTitle = 'Fps Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Fps rainbow', //Name
		"his name say all", //Description
		'rainbowFPS',
		'bool');
		addOption(option);

		var option:Option = new Option('Total Fps', //Name
		"his name say all", //Description
		'totalFPS',
		'bool');
		addOption(option);

		var option:Option = new Option('Engine Version', //Name
		"his name say all", //Description
		'engineVersion',
		'bool');
		addOption(option);

		var option:Option = new Option('Memory peak', //Name
		"his name say all", //Description
		'totalMemory',
		'bool');
		addOption(option);

		var option:Option = new Option('Memory GB', //Name
		"his name say all", //Description
		'memoryGB',
		'bool');
		addOption(option);

		var option:Option = new Option('Memory', //Name
		"his name say all", //Description
		'memory',
		'bool');
		addOption(option);

		var option:Option = new Option('Fps Type:',
		"What should the Fps display?",
		'FpsType',
		'string',
		['Dave engine', 'Psych', 'Original','Purgatory old']);
		addOption(option);

		var option:Option = new Option('Fps Size:',
		"What should the Fps display?",
		'fpssize',
		'string',
		['-1', '1', '2','3']);
		addOption(option);

		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool');
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		super();
	}

	
	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	#end
}
