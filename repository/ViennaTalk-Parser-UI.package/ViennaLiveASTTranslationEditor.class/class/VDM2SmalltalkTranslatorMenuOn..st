menu
VDM2SmalltalkTranslatorMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'VDM->AST translator')
		action: [ self new openWithSpec ];
		order: 0.471;
		parent: #Tools;
		help: 'VDM-SL to AST LIVE translating editor';
		icon: nil