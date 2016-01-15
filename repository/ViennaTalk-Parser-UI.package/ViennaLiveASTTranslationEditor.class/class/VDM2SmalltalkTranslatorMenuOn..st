menu
VDM2SmalltalkTranslatorMenuOn: aBuilder
	<worldMenu>
	((aBuilder item: #VienntaTalkDev)
		parent: #ViennaTalk;
		label: 'dev')
		withSeparatorAfter;
		with: [ 
					(aBuilder item: #'VDM->AST translator')
						action: [ self new openWithSpec ];
						order: 0.1;
						parent: #VienntaTalkDev;
						help: 'VDM-SL to AST LIVE translating editor';
						icon: nil ]