Class {
	#name : 'ViennaLiveSmalltalkTranslationEditor',
	#superclass : 'ViennaLiveTranslationEditor',
	#instVars : [
		'codeText',
		'runtimeTypeCheck',
		'runtimeAssertionCheck'
	],
	#category : 'ViennaTalk-Parser-UI',
	#package : 'ViennaTalk-Parser-UI'
}

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor class >> codeTextMenuFor: aModel [
	^ (PragmaMenuBuilder pragmaKeyword: self codeTextMenuKeyword model: aModel) menuSpec
]

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor class >> codeTextMenuKeyword [
	^ 'viennaCodeTextMenu'
]

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor class >> codeTextMenuOn: aBuilder [
	"Specify the menu used when writing code. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'smalltalkEditorMenu'
		model: nil) menu popUpInWorld
	"

	<contextMenu>
	<viennaCodeTextMenu>
	(aBuilder item: #'Format it' translated)
		keyText: 'F';
		selector: #formatSelectionInCodeText;
		help: 'Pretty print the selected expression/statement/type'.
	(aBuilder item: #'Evaluate it' translated)
		keyText: 'p';
		selector: #viennaItInCodeText;
		help: nil;
		icon: (self iconNamed: #smallPrintItIcon).
	(aBuilder item: #'Translate it' translated)
		keyText: 't';
		selector: #translateIt;
		help: nil;
		icon: (self iconNamed: #smallPrintItIcon);
		withSeparatorAfter.
	(aBuilder item: #'Find...' translated)
		keyText: 'f';
		selector: #find;
		help: nil;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		help: nil;
		icon: (self iconNamed: #smallFindIcon).

	(aBuilder item: #'Code search...' translated)
		selector: #shiftedTextPaneMenuRequest;
		withSeparatorAfter.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		help: nil;
		icon: (self iconNamed: #smallRedoIcon).
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		help: nil;
		icon: (self iconNamed: #smallUndoIcon);
		withSeparatorAfter.
	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		help: nil;
		icon: (self iconNamed: #smallCopyIcon).
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		help: nil;
		icon: (self iconNamed: #smallCutIcon).
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		help: nil;
		icon: (self iconNamed: #smallPasteIcon).
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		help: nil;
		icon: (self iconNamed: #smallCopyIcon);
		withSeparatorAfter
]

{ #category : 'specs' }
ViennaLiveSmalltalkTranslationEditor class >> defaultLayout [

	<spec: #default>
	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   add: #runtimeTypeCheck;
				   add: #runtimeAssertionCheck)
		  expand: false;
		  add: (SpPanedLayout newVertical
				   add: (SpPanedLayout newHorizontal
						    add: #sourceText;
						    add: #targetText);
				   add: #codeText);
		  yourself
]

{ #category : 'class initialization' }
ViennaLiveSmalltalkTranslationEditor class >> initialize [
	super initialize.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor class >> viennaDevMenuOn: aBuilder [

	<ViennaDev>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new open ];
		order: 0.21;
		withSeparatorAfter;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil
]

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new open ];
		order: 0.2;
		parent: #ViennaTalkObsolete;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil
]

{ #category : 'accessing' }
ViennaLiveSmalltalkTranslationEditor >> codeText [
	^ codeText
]

{ #category : 'menu' }
ViennaLiveSmalltalkTranslationEditor >> codeTextMenu [
	^ self class codeTextMenuFor: self
]

{ #category : 'private' }
ViennaLiveSmalltalkTranslationEditor >> createTranslator [
	^ [ :string | 
	| generator |
	generator := ViennaVDM2SmalltalkScript new
		runtimeTypeCheck: runtimeTypeCheck state;
		runtimeAssertionCheck: runtimeAssertionCheck state;
		yourself.
	generator
		translate: string
		ifError: [ 
			generator
				translateStatement: string
				ifError: [ ViennaVDM2SmalltalkScript translateExpression: string ifError: [ :err | err ] ] ] ]
]

{ #category : 'accessing' }
ViennaLiveSmalltalkTranslationEditor >> defaultTitle [
	^ 'VDM -> Smalltalk'
]

{ #category : 'accessing' }
ViennaLiveSmalltalkTranslationEditor >> format: aString [
	^ (RBParser parseExpression: aString) formattedCode
]

{ #category : 'VDM manipulations' }
ViennaLiveSmalltalkTranslationEditor >> formatSelectionInCodeText [
	| parser editor ast result |
	parser := ViennaVDMParser new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast := parser expression end / parser statement end / parser type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	ast isPetit2Failure
		ifTrue: [ ^ codeText notify: ast message at: ast position + 1 in: codeText text ].
	result := ast source.
	editor replaceSelectionWith: result.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex - 1;
		textChanged;
		scrollSelectionIntoView.
	^ true
]

{ #category : 'initialize-release' }
ViennaLiveSmalltalkTranslationEditor >> initializeWidgets [

	super initializeWidgets.
	targetText help: 'Smalltalk code'.
	codeText := self newCode.
	codeText
		help: 'VDM expression/statement/type to evaluate';
		autoAccept: true;
		overridingContextMenu;
		contextMenu: [ self codeTextMenu ];
		bindKeyCombination: $f shift command
		toAction: [ self formatSelectionInCodeText ];
		bindKeyCombination: $p command
		toAction: [ self viennaItInCodeText ];
		bindKeyCombination: $p control
		toAction: [ self viennaItInCodeText ];
		bindKeyCombination: $t command toAction: [ self translateIt ];
		bindKeyCombination: $t control toAction: [ self translateIt ];
		whenBuiltDo: [
			codeText withAdapterDo: [ :a |
					a widgetDo: [ :widget | widget font: ViennaLauncher font ] ] ].
	runtimeTypeCheck := self newCheckBox.
	runtimeTypeCheck
		label: 'runtime type check';
		state: true;
		whenChangedDo: [ self translate ].
	runtimeAssertionCheck := self newCheckBox.
	runtimeAssertionCheck
		label: 'runtime assertion check';
		state: true;
		whenChangedDo: [ self translate ]
]

{ #category : 'accessing' }
ViennaLiveSmalltalkTranslationEditor >> runtimeAssertionCheck [
	^ runtimeAssertionCheck
]

{ #category : 'accessing' }
ViennaLiveSmalltalkTranslationEditor >> runtimeTypeCheck [
	^ runtimeTypeCheck
]

{ #category : 'evaluating' }
ViennaLiveSmalltalkTranslationEditor >> translateIt [
	| parser editor ast codeFromSelection |
	parser := ViennaVDMParser new.
	editor := codeText adapter widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast := parser expression end / parser statement end / parser type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	ast isPetit2Failure
		ifTrue: [ ^ codeText notify: ast message at: ast position + 1 in: codeText text ].
	codeFromSelection := ViennaVDM2SmalltalkScript new generate: ast.
	editor afterSelectionInsertAndSelect: codeFromSelection.
	codeText adapter widget
		selectFrom: editor startIndex to: editor stopIndex;
		textChanged.
	^ true
]

{ #category : 'evaluating' }
ViennaLiveSmalltalkTranslationEditor >> viennaItInCodeText [
	^ self viennaItIn: codeText
]
