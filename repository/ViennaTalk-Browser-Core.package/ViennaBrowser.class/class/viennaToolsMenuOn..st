world menu
viennaToolsMenuOn: aBuilder
	<ViennaTools>
	(aBuilder item: #'VDM Browser')
		action: [ self open ];
		order: 0.1;
		help: 'VDM-SL browser';
		icon: nil