world menu
livelyWalkThroughMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openVDMJ ];
		order: 0.481;
		parent: #Tools;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil.
	aBuilder withSeparatorAfter