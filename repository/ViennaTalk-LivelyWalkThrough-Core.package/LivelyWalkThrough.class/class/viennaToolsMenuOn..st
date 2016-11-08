world menu
viennaToolsMenuOn: aBuilder
	<ViennaToolsMenu>
	(aBuilder item: #'Lively WalkThrough')
		action: [ self openDefault ];
		order: 0.2;
		help: 'Lively Walk-Through, a UI prototyping environment using VDM-SL';
		icon: nil