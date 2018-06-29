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
		order: 0.47;
		parent: #Tools;
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
	(aBuilder item: #'Evaluate it' translated)
		keyText: 'p';
		selector: #viennaItInCodeText;
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
ViennaLiveSmalltalkTranslationEditor class >> sourceTextMenuFor: aModel [
	^ (PragmaMenuBuilder pragmaKeyword: self sourceTextMenuKeyword model: aModel) menu
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> sourceTextMenuKeyword [
	^ 'viennaSourceTextMenu'
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> sourceTextMenuOn: aBuilder [
	"Specify the menu used when writing code. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'smalltalkEditorMenu'
		model: nil) menu popUpInWorld
	"

	<contextMenu>
	<viennaSourceTextMenu>
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

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> codeText [
	^ codeText
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor >> codeTextMenu [
	^ self class codeTextMenuFor: self
]

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> defaultTitle [
	^ 'VDM -> Smalltalk'
]

{ #category : #accessing }
ViennaLiveSmalltalkTranslationEditor >> format: aString [
	^ (RBParser parseExpression: aString) formattedCode
]

{ #category : #'initialize-release' }
ViennaLiveSmalltalkTranslationEditor >> initializeWidgets [
	super initializeWidgets.
	sourceText
		menuHolder: [ self sourceTextMenu ];
		bindKeyCombination: $p command toAction: [ self viennaItInSourceText ].
	targetText help: 'Smalltalk code'.
	codeText := self newText.
	codeText
		help: 'VDM expression/statement/type to evaluate';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		menuHolder: [ self codeTextMenu ];
		bindKeyCombination: $p command toAction: [ self viennaItInCodeText ]
]

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor >> sourceTextMenu [
	^ self class sourceTextMenuFor: self
]

{ #category : #'class access' }
ViennaLiveSmalltalkTranslationEditor >> translatorClass [
	^ ViennaVDM2SmalltalkTranslator
]

{ #category : #evaluating }
ViennaLiveSmalltalkTranslationEditor >> viennaItIn: aTextModel [
	| compiler source codeFromSource editor codeFromSelection result |
	compiler := ViennaVDM2SmalltalkTranslator new.
	source := sourceText text asString.
	codeFromSource := compiler document parse: source.
	codeFromSource isPetitFailure
		ifTrue: [ ^ sourceText notify: codeFromSource message at: codeFromSource position + 1 in: source ].
	editor := aTextModel widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	codeFromSelection := compiler expression end / compiler statement end / compiler type end
		parse: (aTextModel text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	codeFromSelection isPetitFailure
		ifTrue: [ ^ aTextModel notify: codeFromSelection message at: codeFromSelection position + 1 in: aTextModel text ].
	result := (Compiler evaluate: codeFromSource , '.' , codeFromSelection) viennaString.
	editor afterSelectionInsertAndSelect: result
]

{ #category : #evaluating }
ViennaLiveSmalltalkTranslationEditor >> viennaItInCodeText [
	self viennaItIn: codeText
]

{ #category : #evaluating }
ViennaLiveSmalltalkTranslationEditor >> viennaItInSourceText [
	self viennaItIn: sourceText
]
