menu
sourceTextMenuOn: aBuilder
	"Specify the menu used when writing code. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'smalltalkEditorMenu'
		model: nil) menu popUpInWorld
	"

	<contextMenu>
	<viennaSourceTextMenu>
	(aBuilder item: #Format translated)
		keyText: 'F';
		selector: #formatSourceText;
		help: 'Pretty print VDM source'.
	(aBuilder item: #'Evaluate it' translated)
		keyText: 'p';
		selector: #viennaItInSourceText;
		help: nil;
		icon: Smalltalk ui icons smallPrintItIcon;
		withSeparatorAfter.
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		help: nil;
		icon: Smalltalk ui icons smallFindIcon.
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		help: nil;
		icon: Smalltalk ui icons smallFindIcon.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		help: nil;
		icon: Smalltalk ui icons smallRedoIcon.
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		help: nil;
		icon: Smalltalk ui icons smallUndoIcon;
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		help: nil;
		icon: Smalltalk ui icons smallCopyIcon.
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		help: nil;
		icon: Smalltalk ui icons smallCutIcon.
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		help: nil;
		icon: Smalltalk ui icons smallPasteIcon.
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		help: nil;
		icon: Smalltalk ui icons smallCopyIcon;
		withSeparatorAfter