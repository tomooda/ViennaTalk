settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #ViennaTalk)
		label: 'ViennaTalk';
		with: [ 
					(aBuilder setting: #font)
						target: self;
						description: 'The default font for VDM sources';
						label: 'Font' ]