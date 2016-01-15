menu
viennaDevMenuOn: aBuilder
	<ViennaDev>
	(aBuilder item: #'VDM->AST translator')
		action: [ self new openWithSpec ];
		order: 0.1;
		help: 'VDM-SL to AST LIVE translating editor';
		icon: nil