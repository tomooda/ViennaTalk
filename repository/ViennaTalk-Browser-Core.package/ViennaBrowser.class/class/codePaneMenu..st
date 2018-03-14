menu
codePaneMenu: aBuilder
	<contextMenu>
	<viennaBrowserCodePaneMenu>
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		icon: Smalltalk ui icons smallFindIcon.
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		icon: Smalltalk ui icons smallFindIcon.
	(aBuilder item: #'Set search string' translated)
		keyText: 'h';
		selector: #setSearchString;
		withSeparatorAfter.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		icon: Smalltalk ui icons smallRedoIcon.
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		icon: Smalltalk ui icons smallUndoIcon;
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		icon: Smalltalk ui icons smallCopyIcon.
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		icon: Smalltalk ui icons smallCutIcon.
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		icon: Smalltalk ui icons smallPasteIcon.
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		icon: Smalltalk ui icons smallPasteIcon;
		withSeparatorAfter.
	aBuilder model otherModules
		ifNotEmpty: [ :modules | 
			(aBuilder
				item: #'Insert module...' translated;
				withSeparatorAfter)
				with: [ modules
						do: [ :module | 
							(aBuilder item: module asSymbol)
								selector: #insertModuleSource:;
								arguments: (Array with: module asString) ] ] ].
	(aBuilder item: #Format translated)
		keyText: 'F';
		selector: #prettyPrint;
		withSeparatorAfter.
	(aBuilder item: #'Do it' translated)
		keyText: 'd';
		selector: #codePaneDoIt.
	(aBuilder item: #'Print it' translated)
		keyText: 'p';
		selector: #codePanePrintIt;
		withSeparatorAfter.
	(aBuilder item: #Accept translated)
		keyText: 's';
		selector: #accept.
	(aBuilder item: #Cancel translated)
		keyText: 'l';
		selector: #cancel