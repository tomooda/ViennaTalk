world menu
VDMBrowserMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'VDM Browser')
		action: [ self open ];
		order: 0.48;
		parent: #Tools;
		help: 'VDM-SL browser';
		icon: nil