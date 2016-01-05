menus
WeblyBrowserMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'Webly WalkThrough')
		action: [ self open ];
		order: 0.482;
		parent: #Tools;
		help: 'Webly Walk-Through';
		icon: nil.
	aBuilder withSeparatorAfter