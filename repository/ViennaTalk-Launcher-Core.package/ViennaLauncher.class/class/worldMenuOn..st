menu
worldMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #ViennaTalk)
		icon: self viennaIcon;
		withSeparatorAfter;
		with: [ 
					(aBuilder item: #ViennaLauncher)
						parent: #ViennaTalk;
						action: [ self open ];
						order: 0.0;
						help: 'open a ViennaTalk launcher';
						icon: nil ]