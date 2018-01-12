world menu
VDMBrowserMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'VDM Directory Browser')
		action: [ self open ];
		order: 0.11;
		parent: #ViennaTalk;
		help: 'File-based VDM-SL browser';
		icon: nil