package options;

class HealthBarSettingsState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Health Bar';
		rpcTitle = 'Health Bar Settings Menu'; //for Discord Rich Presence
		

		var option:Option = new Option('Health Bar Overlay:',
		"What should the Health bar Overlay display?",
		'healthBarOverlay',
		'string',
		['OG', 'Purgatory', 'Strident Crisis','OS','3D','Hell','Golden Apple','Animated','Disabled']);
		addOption(option);

		var option:Option = new Option('Original Time bar colors',
		'His name say all.',
		'originalhealthbarColor',
		'bool');
		addOption(option);

		var option:Option = new Option('Health Bar Type:',
		"What should the Health bar Type display?",
		'healthBarType',
		'string',
		['OG', 'Yuyio', 'Circle']);
		addOption(option);

		var option:Option = new Option('Score Text Type:',
		"Select a type of score text.",
		'scoreTxtType',
		'string',
		['Psych','Purgatory','Purgatory old','Redux New', 'Redux Classic', 'Simple', 'Advanced', 'Andromeda', 'Forever', 'Leather', 'PFNF Legacy', 'PFNF 2.0', 'Only Score', 'Disabled']);
	addOption(option);

		var option:Option = new Option('Health Bar Position:',
		"What should the Health bar position?",
		'healthBarPosition',
		'string',
		['Vertical (Left)', 'Vertical (Right)', 'Horizontal', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Health Bar Opacity',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Icon bop Type:',
		"Iconbop",
		'iconBop',
		'string',
		['Psych','Purgatory','Purgatory old','Os', 'SB engine','PFNF','Modern','Dave','Gapple','Fixed Build']);
		addOption(option);

		super();
	}
}
