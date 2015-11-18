menu
VDM2SmalltalkTranslatorMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new openWithSpec ];
		order: 0.47;
		parent: #Tools;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil