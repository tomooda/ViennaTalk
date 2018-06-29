Class {
	#name : #LWTFieldWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'contents',
		'textFont',
		'textMorph',
		'showsDiagram'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #'menu declaration' }
LWTFieldWidget class >> textEditorMenuOn: aBuilder [ 
	"Specify the menu used when writing text. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'textEditorMenu'
		model: nil) menu popUpInWorld"

	<contextMenu>
	<vdmTextEditorMenu>

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
		selector: #setSearchString.
	(aBuilder item: #'Do again' translated) 
		keyText: 'j';
		selector: #again; 
		icon: Smalltalk ui icons smallRedoIcon.
	(aBuilder item: #'Undo' translated) 
		keyText: 'z';
		selector: #undo; 
		icon: Smalltalk ui icons smallUndoIcon; 
		withSeparatorAfter.
	
	(aBuilder item: #'Copy' translated) 
		keyText: 'c';
		selector: #copySelection; 
		icon: Smalltalk ui icons smallCopyIcon.
	(aBuilder item: #'Cut' translated) 
		keyText: 'x';
		selector: #cut; 
		icon: Smalltalk ui icons smallCutIcon.
	(aBuilder item: #'Paste' translated) 
		keyText: 'v';
		selector: #paste; 
		icon: Smalltalk ui icons smallPasteIcon.
	(aBuilder item: #'Paste...' translated) 
		selector: #pasteRecent; 
		icon: Smalltalk ui icons smallCopyIcon; 
		withSeparatorAfter.
	(aBuilder item: #'Accept' translated) 
		keyText: 's';
		selector: #accept; 
		icon: Smalltalk ui icons smallOkIcon.
	(aBuilder item: #'Cancel' translated) 
		keyText: 'l';
		selector: #cancel; 
		icon: Smalltalk ui icons smallCancelIcon.
]

{ #category : #'menu declaration' }
LWTFieldWidget class >> yellowButtonMenu [
	^ (PragmaMenuBuilder pragmaKeyword: 'vdmTextEditorMenu' model: nil) menu
]

{ #category : #accessing }
LWTFieldWidget >> acceptContents: aStringOrText [
	| oldContents |
	oldContents := contents.
	contents := aStringOrText asString.
	contents ~= oldContents ifTrue: [ self event: #changed ].
	^ true
]

{ #category : #events }
LWTFieldWidget >> availableEventSelectors [
	^ #(changed)
]

{ #category : #accessing }
LWTFieldWidget >> basename [
	^ 'Field'
]

{ #category : #'initialize-release' }
LWTFieldWidget >> buildTextPane [
	textMorph := PluggableTextMorph
		on: self
		text: #contents
		accept: #acceptContents:
		readSelection: nil
		menu: #textPaneMenu:shifted:.
	textMorph
		acceptOnCR: true;
		acceptOnFocusChange: true;
		borderColor: Color black;
		borderWidth: 1;
		font: self textFont;
		showHScrollBarOnlyWhenNeeded: true;
		hideVScrollBarIndefinitely: false.
	self changeProportionalLayout.
	self addMorph: textMorph fullFrame: self layoutFrameForTextPane.
	^ textMorph
]

{ #category : #operations }
LWTFieldWidget >> changeTextFont [
	self
		openModal:
			(FontChooser
				openWithWindowTitle: 'Choose a font for the text'
				for: self
				setSelector: #textFont:
				getSelector: #textFont)
]

{ #category : #accessing }
LWTFieldWidget >> contents [
	^ contents ifNil: [ self defaultContents ]
]

{ #category : #defaults }
LWTFieldWidget >> defaultContents [
	^ String new
]

{ #category : #defaults }
LWTFieldWidget >> defaultExtent [
	^ 200 @ 60
]

{ #category : #defaults }
LWTFieldWidget >> defaultTextFont [
	^ TextStyle default defaultFont
]

{ #category : #drawing }
LWTFieldWidget >> drawOn: aCanvas [
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color white
		borderWidth: 1
		borderColor: Color lightGray.
	super drawOn: aCanvas
]

{ #category : #'event handling' }
LWTFieldWidget >> handlesMouseDown: anEvent [
	self
		allMorphsDo: [ :m | 
			(m ~~ self and: [ (m bounds insetBy: self edgePrecision) containsPoint: anEvent position ])
				ifTrue: [ ^ false ] ].
	^ super handlesMouseDown: anEvent
]

{ #category : #operations }
LWTFieldWidget >> hideDiagram [
	showsDiagram := false.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed
]

{ #category : #operations }
LWTFieldWidget >> hideName [
	super hideName.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ]
]

{ #category : #'initialize-release' }
LWTFieldWidget >> initialize [
	super initialize.
	showsDiagram := false.
	self extent: self defaultExtent.
	self buildTextPane
]

{ #category : #geometry }
LWTFieldWidget >> layoutFrameForTextPane [
	^ self showsDiagram
		ifTrue: [ 
			(LayoutFrame fractions: (0 @ 0 corner: 1 @ 0))
				topOffset: self textOffset y;
				bottomOffset: self textOffset y + self textExtent y;
				yourself ]
		ifFalse: [ 
			(LayoutFrame fractions: (0 @ 0 corner: 1 @ 1))
				topOffset: self textOffset y;
				yourself ]
]

{ #category : #menus }
LWTFieldWidget >> menu [
	| menu |
	menu := super menu.
	menu add: 'change text font' translated target: self selector: #changeTextFont.
	self showsDiagram
		ifTrue: [ 
			menu
				add: 'change diagram font' translated target: self selector: #changeDiagramFont;
				add: 'change diagram color' translated target: self selector: #changeDiagramColor;
				add: 'hide diagram' translated target: self selector: #hideDiagram ]
		ifFalse: [ menu add: 'show diagram' translated target: self selector: #showDiagram ].
	^ menu
]

{ #category : #operations }
LWTFieldWidget >> showDiagram [
	showsDiagram := true.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed
]

{ #category : #operations }
LWTFieldWidget >> showName [
	super showName.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ]
]

{ #category : #testing }
LWTFieldWidget >> showsDiagram [
	^ showsDiagram = true
]

{ #category : #geometry }
LWTFieldWidget >> textExtent [
	^ self width @ 50
]

{ #category : #accessing }
LWTFieldWidget >> textFont [
	^ textFont ifNil: [ textFont := self defaultTextFont ]
]

{ #category : #accessing }
LWTFieldWidget >> textFont: aFont [
	textFont := aFont.
	textMorph ifNotNil: [ :m | m font: aFont ].
	self changed
]

{ #category : #geometry }
LWTFieldWidget >> textOffset [
	^ 0
		@
			(self nameOffset y
				+
					(self showsName
						ifTrue: [ self nameExtent y + 3 ]
						ifFalse: [ 0 ]))
]

{ #category : #menus }
LWTFieldWidget >> textPaneMenu: aMenu shifted: aBoolean [
	^ aMenu addAllFrom: self class yellowButtonMenu
]

{ #category : #accessing }
LWTFieldWidget >> value [
	^ self contents
]

{ #category : #accessing }
LWTFieldWidget >> value: aStringOrText [
	self acceptContents: aStringOrText.
	self changed: #contents
]
