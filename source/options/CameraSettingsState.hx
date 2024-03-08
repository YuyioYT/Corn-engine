package options;

class CameraSettingsState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Camera';
		rpcTitle = 'Camera Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Camera Zooms',
		"If unchecked, the camera won't zoom in on a beat hit.",
		'camZooms',
		'bool');
		addOption(option);

		var option:Option = new Option('Camera Zooms in boyfriend or opponent',
		"Make a camera zoom like default cam zoom",
		'ZoomInorOut',
		'bool');
		addOption(option);

		var option:Option = new Option('Camera Zooms in boyfriend or opponent Per beat',
		"Make a camera zoom like default cam zoom Per beat",
		'ZoomInorOutPerBeat',
		'bool');
		addOption(option);

		var option:Option = new Option('Cam Zoom Type:',
		"Type of camera zoom",
		'camZoomType',
		'string',
		['Psych', 'Yuyio']);
		addOption(option);

		var option:Option = new Option('Update Camera',
		"If checked, you get a Update camera.",
		'updatecam',
		'bool');
	    addOption(option);

		var option:Option = new Option('Move Camera on countdown',
		"If checked, you get a Move camera when start de countdown.",
		'moveCameraonCountdown',
		'bool');
	    addOption(option);

		var option:Option = new Option('Follow Cam On Note Hit',
		"If checked, you get a movement on hit an arrow.",
		'followarrow',
		'bool');
	    addOption(option);

		var option:Option = new Option('Angle Cam On Note Hit',
		"If checked, you get a angle on hit an arrow.",
		'cameraAngle',
		'bool');
	    addOption(option);

		var option:Option = new Option('Zoom Cam On Note Hit',
		"If checked, you get a zoom on hit an arrow.",
		'ZoomonNotehit',
		'bool');
	    addOption(option);

		var option:Option = new Option('Character in middle screen',
		"his name say all",
		'middlecameracharacter',
		'bool');
	    addOption(option);

		var option:Option = new Option('Smooth camera',
		"his name say all",
		'Smoothcamera',
		'bool');
	    addOption(option);

		var option:Option = new Option('Intesity Cam Follow',
		'His name say all',
		'intensityfollowcam',
		'int');
		option.scrollSpeed = 30;
		option.minValue = -200;
		option.maxValue = 200;
		option.changeValue = 5;
		addOption(option);

		var option:Option = new Option('Intesity Cam Angle',
		'His name say all',
		'intensitycameraAngle',
		'int');
		option.scrollSpeed = 30;
		option.minValue = -360;
		option.maxValue = 360;
		option.changeValue = 5;
		addOption(option);

		var option:Option = new Option('Intesity Cam Zoom',
			'Changes how many Zoom you can have',
			'intensitycamerazoom',
			'float');
		option.scrollSpeed = 5;
		option.minValue = -1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);
		
		super();
	}
}
