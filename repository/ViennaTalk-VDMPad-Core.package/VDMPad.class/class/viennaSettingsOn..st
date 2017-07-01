settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #isRunning)
		parent: #ViennaTalkServices;
		target: self;
		description:
				'If checked then a VDMPad server will be up so that it can be accessed by web browsers and Vienna clients.';
		label: 'VDMPad';
		order: 0.1;
		with: [ 
					(aBuilder setting: #localOnly)
						target: self;
						description:
								'If checked then a VDMPad server will serve only from localhost. Accesses from other hosts will be rejected.';
						label: 'Serves for only localhost' ]