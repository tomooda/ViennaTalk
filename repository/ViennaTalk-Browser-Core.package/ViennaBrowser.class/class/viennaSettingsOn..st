settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #ViennaTalkUnitTesting)
		parent: #ViennaTalk;
		label: 'Unit Testing';
		with: [ (aBuilder setting: #autoTest)
				target: self;
				getSelector: #autoTest;
				setSelector: #autoTest:;
				description: 'If checked, then VDMBrowser will automatically run unit testing.';
				label: 'Auto unit testing in VDM Browser';
				order: 0.501;
				with: [ (aBuilder setting: #autoFullTest)
						target: self;
						getSelector: #autoFullTest;
						setSelector: #autoFullTest:;
						description: 'If checked, then VDMBrowser will automatically run all test modules.';
						label: 'full tests';
						order: 0.501 ] ].
	(aBuilder setting: #autoFormat)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #autoFormat;
		setSelector: #autoFormat:;
		description: 'If checked, then VDMBrowser will automatically format the VDM source.';
		label: 'Auto format in VDM Browser';
		order: 0.50