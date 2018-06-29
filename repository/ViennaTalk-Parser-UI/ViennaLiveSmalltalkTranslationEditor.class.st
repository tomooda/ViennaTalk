Class {
	#name : #ViennaLiveSmalltalkTranslationEditor,
	#superclass : #ViennaLiveTranslationEditor,
	#instVars : [
		'codeText'
	],
	#category : 'ViennaTalk-Parser-UI'
}

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> VDM2SmalltalkTranslatorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new openWithSpec ];
		order: 0.2;
		parent: #VienntaTalkDev;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> codeTextMenuFor: aModel [
	^ (PragmaMenuBuilder pragmaKeyword: self codeTextMenuKeyword model: aModel) menu
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> codeTextMenuKeyword [
	^ 'viennaCodeTextMenu'
]

{ #category : #menu }
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
		icon: Smalltalk ui icons smallPrintItIcon.
	(aBuilder item: #'Translate it' translated)
		keyText: 't';
		selector: #translateIt;
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
	UserManager default canBrowse
		ifTrue: [ 
			(aBuilder item: #'Code search...' translated)
				selector: #shiftedTextPaneMenuRequest;
				withSeparatorAfter ].
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
]

{ #category : #specs }
ViennaLiveSmalltalkTranslationEditor class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						newRow: [ :row | 
									row
										add: #sourceText;
										addSplitter;
										add: #targetText ];
						addSplitter;
						newRow: [ :row | row add: #codeText ];
						yourself ];
		yourself
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> viennaDevMenuOn: aBuilder [
	<ViennaDev>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new openWithSpec ];
		order: 0.2;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil
]

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> codeText [
	^ codeText
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor >> codeTextMenu [
	^ self class codeTextMenuFor: self
]

{ #category : #private }
ViennaLiveSmalltalkTranslationEditor >> createTranslator [
	^ ViennaVDM2SmalltalkTranslator new document end
]

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> defaultTitle [
	^ 'VDM -> Smalltalk'
]

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> format: aString [
	^ (RBParser parseExpression: aString) formattedCode
]

{ #category : #'VDM manipulations' }
ViennaLiveSmalltalkTranslationEditor >> formatSelectionInCodeText [
	| parser editor ast result |
	parser := ViennaVDMParser new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast := parser expression end / parser statement end / parser type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	ast isPetitFailure
		ifTrue: [ ^ codeText notify: ast message at: ast position + 1 in: codeText text ].
	result := ast format.
	editor replaceSelectionWith: result.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex - 1;
		textChanged;
		scrollSelectionIntoView.
	^ true
]

{ #category : #'initialize-release' }
ViennaLiveSmalltalkTranslationEditor >> initializeWidgets [
	super initializeWidgets.
	targetText help: 'Smalltalk code'.
	codeText := self newText.
	codeText
		help: 'VDM expression/statement/type to evaluate';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		wantsVisualFeedback: true;
		menuHolder: [ self codeTextMenu ];
		bindKeyCombination: $f shift command toAction: [ self formatSelectionInCodeText ];
		bindKeyCombination: $p command toAction: [ self viennaItInCodeText ];
		bindKeyCombination: $t command toAction: [ self translateIt ];
		whenBuiltDo: [ codeText widget font: ViennaLauncher font ]
]

{ #category : #evaluating }
ViennaLiveSmalltalkTranslationEditor >> translateIt [
	| compiler editor codeFromSelection |
	compiler := ViennaVDM2SmalltalkTranslator new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	codeFromSelection := compiler expression end / compiler statement end / compiler type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	codeFromSelection isPetitFailure
		ifTrue: [ ^ codeText notify: codeFromSelection message at: codeFromSelection position + 1 in: codeText text ].
	editor afterSelectionInsertAndSelect: codeFromSelection.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex;
		textChanged;
		scrollSelectionIntoView.
	^ true
]

{ #category : #evaluating }
ViennaLiveSmalltalkTranslationEditor >> viennaItInCodeText [
	^ self viennaItIn: codeText
]
