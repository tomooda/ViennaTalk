settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #ViennaTalk)
		label: 'ViennaTalk';
		with: [ (aBuilder group: #ViennaTalkAppearances)
				label: 'Appearances';
				with: [ (aBuilder setting: #font)
						target: self;
						description: 'The default font for VDM sources';
						label: 'Font';
						order: 0.1 ].
			(aBuilder group: #ViennaTalkCodeGenerator) label: 'Code Generator'.
			(aBuilder group: #ViennaTalkServices) label: 'Services' ]