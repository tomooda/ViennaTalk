settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #defaultViennaServerUrl)
		parent: #ViennaTalk;
		target: self;
		getSelector: #defaultUrlString;
		setSelector: #defaultUrlString:;
		description: 'The default ViennaServer url (used by ViennaClient)';
		label: 'default Vienna server URL'