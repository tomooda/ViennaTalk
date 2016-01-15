servicing
worldMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'VDMPad server')
		parent: #ViennaTalk;
		withSeparatorAfter;
		with: [ 
					(aBuilder item: #VDMPadStart)
						label: 'start';
						action: [ self startService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'start VDMPad server';
						icon: nil;
						enabledBlock: [ self isRunning not ].
					(aBuilder item: #VDMPadStop)
						label: 'stop';
						action: [ self stopService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'stop VDMPad server';
						icon: nil;
						enabledBlock: [ self isRunning ] ]