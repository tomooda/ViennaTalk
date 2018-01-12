world menu
viennaToolsMenuOn: aBuilder
	<ViennaToolsMenu>
	(aBuilder item: #'VDM Directory Browser')
		action: [ self open ];
		order: 0.11;
		help: 'File-based VDM-SL browser';
		icon: nil