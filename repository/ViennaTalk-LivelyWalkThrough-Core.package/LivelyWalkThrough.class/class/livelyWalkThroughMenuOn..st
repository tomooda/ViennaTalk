world menu
livelyWalkThroughMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openDefault ];
		order: 0.2;
		parent: #ViennaTalk;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil