servicing
viennaToolsMenuOn: aBuilder
	<ViennaTools>
	(aBuilder item: #'VDMPad server')
		withSeparatorAfter;
		with: [ 
					(aBuilder item: #VDMPadStart)
						label: 'start';
						action: [ self startService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'start VDMPad server';
						icon: nil;
						precondition: [ self isRunning not ].
					(aBuilder item: #VDMPadStop)
						label: 'stop';
						action: [ self stopService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'stop VDMPad server';
						icon: nil;
						precondition: [ self isRunning ] ]