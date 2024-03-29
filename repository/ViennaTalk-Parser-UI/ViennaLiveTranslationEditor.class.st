Class {
	#name : #ViennaLiveTranslationEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceText',
		'targetText',
		'translator',
		'process'
	],
	#category : #'ViennaTalk-Parser-UI'
}

{ #category : #layout }
ViennaLiveTranslationEditor class >> defaultLayout [
	<spec: #default>
	^ SpPanedLayout newHorizontal
						add: #sourceText;
						add: #targetText;
		yourself
]

{ #category : #menu }
ViennaLiveTranslationEditor class >> sourceTextMenuFor: aModel [
	^ (PragmaMenuBuilder pragmaKeyword: self sourceTextMenuKeyword model: aModel) menuSpec
]

{ #category : #menu }
ViennaLiveTranslationEditor class >> sourceTextMenuKeyword [
	^ 'viennaSourceTextMenu'
]

{ #category : #menu }
ViennaLiveTranslationEditor class >> sourceTextMenuOn: aBuilder [
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
]

{ #category : #private }
ViennaLiveTranslationEditor >> createTranslator [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> defaultTitle [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> format: aString [
	^ aString
]

{ #category : #'VDM manipulations' }
ViennaLiveTranslationEditor >> formatSourceText [
	^ sourceText text: (ViennaVDMParser new format: sourceText text asString) 
]

{ #category : #'initialize-release' }
ViennaLiveTranslationEditor >> initializeWidgets [

	sourceText := self newText.
	sourceText
		help: 'VDM source';
		autoAccept: true;
		withoutEditionContextMenu;
		contextMenu: [ self sourceTextMenu ];
		bindKeyCombination: $f shift command
		toAction: [ self formatSourceText ];
		bindKeyCombination: $p command
		toAction: [ self viennaItInSourceText ];
		bindKeyCombination: $p control
		toAction: [ self viennaItInSourceText ];
		whenTextChangedDo: [ 
			[ self translate ] forkAt: Processor userBackgroundPriority ];
		whenBuiltDo: [ 
			sourceText withWidgetDo: [ :w | w font: ViennaLauncher font ] ].
	targetText := self newText.
	targetText
		help: 'Translation output';
		whenBuiltDo: [ 
			targetText withWidgetDo: [ :w | w font: ViennaLauncher font ] ]
]

{ #category : #'initialize-release' }
ViennaLiveTranslationEditor >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter title: self defaultTitle
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> sourceText [
	^ sourceText
]

{ #category : #menu }
ViennaLiveTranslationEditor >> sourceTextMenu [
	^ self class sourceTextMenuFor: self
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> targetText [
	^ targetText
]

{ #category : #private }
ViennaLiveTranslationEditor >> translate [

	| source |
	source := sourceText text asString.
	[ 
	| failure |
	failure := nil.
	targetText text: (self translate: source ifError: [ :error | 
			 failure := error.
			 '' ]).
	failure ifNotNil: [ 
		sourceText text: (source
				 addAttribute: TextColor red
				 from: failure position + 1
				 to: source size) ] ]
		on: Error
		do: [ :ex |  ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translate: aTextOrString ifError: errorBlock [
	^ (self translator value: aTextOrString asString)
		in: [ :result | 
			result isPetit2Failure
				ifTrue: [ errorBlock value: result ]
				ifFalse: [ self format: result ] ]
]

{ #category : #accessing }
ViennaLiveTranslationEditor >> translator [
	^ translator ifNil: [ translator := self createTranslator ]
]

{ #category : #evaluating }
ViennaLiveTranslationEditor >> viennaItIn: aTextModel [

	| parser codeFromSource editor ast codeFromSelection result |
	parser := ViennaVDMParser new.
	codeFromSource := targetText text asString.
	aTextModel withWidgetDo: [ :widget | 
		editor := widget widget textMorph editor ].
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast := parser expression end / parser statement end / parser type end 
		       parse: (aTextModel text asString
				        copyFrom: editor startIndex
				        to: editor stopIndex - 1) trim.
	ast isPetit2Failure ifTrue: [ 
		^ aTextModel
			  notify: ast message
			  at: ast position + 1
			  in: aTextModel text ].
	codeFromSelection := ViennaVDM2SmalltalkScript new generate: ast.
	result := (OpalCompiler new
		           source: codeFromSource , '.' , codeFromSelection;
		           evaluate) viennaString.
	editor afterSelectionInsertAndSelect: result.
	aTextModel withWidgetDo: [ :widget | 
		widget widget
			selectFrom: editor startIndex to: editor stopIndex - 1;
			textChanged ].
	^ true
]

{ #category : #evaluating }
ViennaLiveTranslationEditor >> viennaItInSourceText [
	^ self viennaItIn: sourceText
]
