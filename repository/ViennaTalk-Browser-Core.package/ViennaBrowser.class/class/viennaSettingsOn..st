settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #autoFormat)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #autoFormat;
		setSelector: #autoFormat:;
		description: 'If checked, then VDMBrowser will automatically format the VDM source.';
		label: 'Auto format in VDM Browser';
		order: 0.50