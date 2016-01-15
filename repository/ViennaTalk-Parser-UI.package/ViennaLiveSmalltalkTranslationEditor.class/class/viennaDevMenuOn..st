menu
viennaDevMenuOn: aBuilder
	<ViennaDev>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new openWithSpec ];
		order: 0.2;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil