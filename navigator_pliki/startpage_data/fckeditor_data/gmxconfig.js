// force german language
FCKConfig.AutoDetectLanguage = false;
FCKConfig.DefaultLanguage = 'de';

// Use BR instead of P for CR in IE 
FCKConfig.UseBROnCarriageReturn	= true;

// Full HTML page editing
FCKConfig.FullPage = true;

// disable toolbar collapse
FCKConfig.ToolbarCanCollapse = false;

// Disable some browsers
FCKConfig.ImageBrowser = false;
FCKConfig.FlashBrowser = false;
FCKConfig.LinkBrowser  = false;

// Disable upload
FCKConfig.LinkUpload  = false;
FCKConfig.ImageUpload = false;
FCKConfig.FlashUpload = false;

// define font related stuff
FCKConfig.FontNames = 'Arial;Comic Sans MS;Courier;Tahoma;Times New Roman;Verdana';
FCKConfig.FontSizes = '1/extra klein;2/sehr klein;3/klein;4/normal;5/groß;6/sehr groß;7/extra groß';
FCKConfig.FontFormats	= 'p;pre;address;h1;h2;h3;h4;h5;h6';

// define toolbars //'SaveMail',
FCKConfig.ToolbarSets["GMX"] = [
	[
		
		'Print',
	   	'Preview',
	   	'-',
		'Undo',
		'Redo',
		'-',
		'Find',
		'Replace',
		'-',
		'JustifyLeft',
		'JustifyCenter',
		'JustifyRight',
		'JustifyFull',
		'-',
		'OrderedList',
		'UnorderedList',
		'Rule',
		'-',
		'Outdent',
		'Indent',
		'-',
		'AddImage',
		'AddSmiley',
		'SpecialChar',
		'Table',
		'-',
		'InsertLink',
		'Unlink'
	],
    '/',
	[
		'FontName',
		'FontSize',
		'-',
		'Bold',
		'Italic',
		'Underline',
		'StrikeThrough',
		'-',
		'TextColor'
	]
];

// add PlugIns
FCKConfig.Plugins.Add('saveMail', null);
FCKConfig.Plugins.Add('addImage', null);
FCKConfig.Plugins.Add('addSmiley', null);
FCKConfig.Plugins.Add('insertLink', null);
FCKConfig.Plugins.Add('handleKeyEvent', null);

// set skin
FCKConfig.SkinPath = FCKConfig.BasePath + 'skins/gmx/';

// redefinition of styles list
FCKConfig.StylesXmlPath = '../gmxstyles.xml';
