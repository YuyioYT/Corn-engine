package options;

class TimeBarSettingsState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Time Bar';
		rpcTitle = 'Time Bar Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('% Decimals: ',
		"The amount of decimals you want for your Song Percentage. (0 means no decimals)",
		'percentDecimals',
		'int');
		addOption(option);

		option.minValue = 0;
		option.maxValue = 50;
		option.displayFormat = '%v Decimals';

		var option:Option = new Option('Show Song Percentage',
		"If checked, you can see text displaying how much\nof the song you've completed.",
		'songPercentage',
		'bool');
		addOption(option);

		var option:Option = new Option('songLength Intro Animation',
		'If checked, the song length will also have an intro animation.',
		'lengthIntro',
		'bool');
		addOption(option);

		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			['Time Left', 'Time Elapsed', 'Song Name', 'Modern Time', 'Song Name + Time', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Time Bar bg color:',
		"What should the Time Bar BG clor display?",
		'timebarBGColor',
		'string',
		['Black','Dark Gray','Gray']);
		addOption(option);
		
		var option:Option = new Option('Time Bar Style:',
		"What should the Time bar Type display?",
		'timeBarStyle',
		'string',
		['OG', 'Yuyio', 'Circle']);
		addOption(option);

		var option:Option = new Option('Color time bar Move',
			"What should the Time Bar display?",
			'ColorBar',
			'string',
			['Disabled','Icon-P1','Icon-P2','Icon-P1 and P2','Icon-P2 and P1']);
		addOption(option);

		var option:Option = new Option('Color time bar BG',
		"What should the Time Bar display?",
		'ColorBarBG',
		'string',
		['Disabled','Icon-P1','Icon-P2','Icon-P1 and P2','Icon-P2 and P1']);
		addOption(option);

		super();
	}
}
