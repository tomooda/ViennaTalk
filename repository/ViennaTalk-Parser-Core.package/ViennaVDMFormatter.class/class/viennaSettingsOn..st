settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #defaultFormatWidth)
		parent: #ViennaTalk;
		target: self;
		getSelector: #defaultMaxSizePerLine;
		setSelector: #defaultMaxSizePerLine:;
		description: 'The default width to format VDM sources.';
		label: 'Format width'