Class {
	#name : #LWTFieldWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'contents',
		'textFont',
		'textMorph',
		'showsDiagram',
		'type'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
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
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Find again' translated)
		keyText: 'g';
		selector: #findAgain;
		icon: (self iconNamed: #smallFindIcon).
	(aBuilder item: #'Set search string' translated)
		keyText: 'h';
		selector: #setSearchString.
	(aBuilder item: #'Do again' translated)
		keyText: 'j';
		selector: #again;
		icon: (self iconNamed: #smallRedoIcon).
	(aBuilder item: #Undo translated)
		keyText: 'z';
		selector: #undo;
		icon: (self iconNamed: #smallUndoIcon);
		withSeparatorAfter.

	(aBuilder item: #Copy translated)
		keyText: 'c';
		selector: #copySelection;
		icon: (self iconNamed: #smallCopyIcon).
	(aBuilder item: #Cut translated)
		keyText: 'x';
		selector: #cut;
		icon: (self iconNamed: #smallCutIcon).
	(aBuilder item: #Paste translated)
		keyText: 'v';
		selector: #paste;
		icon: (self iconNamed: #smallPasteIcon).
	(aBuilder item: #'Paste...' translated)
		selector: #pasteRecent;
		icon: (self iconNamed: #smallCopyIcon);
		withSeparatorAfter.
	(aBuilder item: #Accept translated)
		keyText: 's';
		selector: #accept;
		icon: (self iconNamed: #smallOkIcon).
	(aBuilder item: #Cancel translated)
		keyText: 'l';
		selector: #cancel;
		icon: (self iconNamed: #smallCancelIcon)
]

{ #category : #'menu declaration' }
LWTFieldWidget class >> yellowButtonMenu [
	^ (PragmaMenuBuilder pragmaKeyword: 'vdmTextEditorMenu' model: nil) menu
]

{ #category : #accessing }
LWTFieldWidget >> acceptContents: aStringOrText [
	| oldContents |
	oldContents := contents.
	^ self
		validate: aStringOrText asString
		do: [ :validString | 
			contents := validString.
			self event: #assigned.
			contents ~= oldContents
				ifTrue: [ self event: #changed ].
			true ]
		ifError: [ false ]
]

{ #category : #json }
LWTFieldWidget >> asJsonObject [
	^ super asJsonObject
		at: 'contents' put: contents;
		at: 'textFont' put: (self fontToJsonObject: self textFont);
		at: 'showsDiagram' put: self showsDiagram;
		at: 'type' put: type;
		yourself
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

	textMorph := RubPluggableTextMorph
		             on: self
		             text: #contents
		             accept: #acceptContents:
		             readSelection: nil
		             menu: #textPaneMenu:shifted:.
	textMorph
		autoAccept: true;
		borderColor: Color black;
		borderWidth: 1;
		font: self textFont;
		hScrollbarShowWhenNeeded;
		vScrollbarShowNever.
	self changeProportionalLayout.
	self addMorph: textMorph fullFrame: self layoutFrameForTextPane.
	^ textMorph
]

{ #category : #operations }
LWTFieldWidget >> changeAnyType [
	type := #any
]

{ #category : #operations }
LWTFieldWidget >> changeNumberType [
	type := #number
]

{ #category : #operations }
LWTFieldWidget >> changeStringType [
	type := #string
]

{ #category : #operations }
LWTFieldWidget >> changeTextFont [

	FontChooser
		openModalWithTitle: 'Choose a font for the text'
		initialFont: self textFont
		onAcceptDo: [ :f | self textFont: f ]
]

{ #category : #operations }
LWTFieldWidget >> changeVDMType [
	type := #vdm
]

{ #category : #accessing }
LWTFieldWidget >> contents [
	^ contents ifNil: [ self defaultContents ]
]

{ #category : #private }
LWTFieldWidget >> contents: aStringOrText [
	contents := aStringOrText.
	self changed: #contents
]

{ #category : #validating }
LWTFieldWidget >> contentsToValue: aString [
	type = #string
		ifTrue: [ ^ ViennaWriter new stringify: aString ].
	^ aString
]

{ #category : #defaults }
LWTFieldWidget >> defaultContents [
	^ String new
]

{ #category : #defaults }
LWTFieldWidget >> defaultExtent [
	^ 200 @ 68
]

{ #category : #defaults }
LWTFieldWidget >> defaultTextFont [
	^ ViennaLauncher font
]

{ #category : #defaults }
LWTFieldWidget >> defaultType [
	^ #any
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
	type := self defaultType.
	self buildTextPane
]

{ #category : #testing }
LWTFieldWidget >> isAnyType [
	^ type = #any
]

{ #category : #testing }
LWTFieldWidget >> isNumberType [
	^ type = #number
]

{ #category : #testing }
LWTFieldWidget >> isStringType [
	^ type = #string
]

{ #category : #testing }
LWTFieldWidget >> isVDMType [
	^ type = #vdm
]

{ #category : #geometry }
LWTFieldWidget >> layoutFrameForTextPane [
	^ self showsDiagram
		ifTrue: [ LayoutFrame identity
				bottomFraction: 0;
				leftOffset: 3;
				rightOffset: -3;
				topOffset: self textOffset y;
				bottomOffset: self textOffset y + self textExtent y;
				yourself ]
		ifFalse: [ LayoutFrame identity
				leftOffset: 3;
				rightOffset: -3;
				topOffset: self textOffset y;
				bottomOffset: -3;
				yourself ]
]

{ #category : #menus }
LWTFieldWidget >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'type' translated
		subMenu:
			(MenuMorph new
				defaultTarget: self;
				addToggle: 'number' translated
					target: self
					selector: #changeNumberType
					getStateSelector: #isNumberType;
				addToggle: 'string' translated
					target: self
					selector: #changeStringType
					getStateSelector: #isStringType;
				addToggle: 'vdm value' translated
					target: self
					selector: #changeVDMType
					getStateSelector: #isVDMType;
				addToggle: 'any' translated
					target: self
					selector: #changeAnyType
					getStateSelector: #isAnyType;
				yourself).
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

{ #category : #accessing }
LWTFieldWidget >> showsDiagram [
	^ showsDiagram
]

{ #category : #private }
LWTFieldWidget >> showsDiagram: aBoolean [
	showsDiagram := aBoolean = true
]

{ #category : #geometry }
LWTFieldWidget >> textExtent [
	^ self width - 6 @ 50
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
	^ 3
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
LWTFieldWidget >> type [
	^ type
]

{ #category : #accessing }
LWTFieldWidget >> type: aSymbol [
	type := aSymbol
]

{ #category : #validating }
LWTFieldWidget >> validate: aString do: aBlock ifError: errorBlock [
	type = #number
		ifTrue: [ 
			| vdm |
			vdm := [ ViennaWriter new stringify: (ViennaReader new parseNumberOn: aString trim readStream) ]
				on: Error
				do: [ :ex | ^ errorBlock cull: 'Cannot convert to VDM number' ].
			^ aBlock value: vdm ].
	type = #vdm
		ifTrue: [ 
			| vdm |
			vdm := [ ViennaWriter new stringify: (ViennaReader new parse: aString) ]
				on: Error
				do: [ :ex | ^ errorBlock cull: 'Cannot convert to VDM value' ].
			^ aBlock value: vdm ].
	^ aBlock value: aString
]

{ #category : #accessing }
LWTFieldWidget >> value [
	^ self contentsToValue: self contents
]

{ #category : #accessing }
LWTFieldWidget >> value: aStringOrText [
	self acceptContents: (self valueToContents: aStringOrText).
	self changed: #contents
]

{ #category : #validating }
LWTFieldWidget >> valueToContents: aString [
	type = #string
		ifTrue: [ ^ ViennaReader new parseStringOn: aString trim readStream ].
	^ aString
]
