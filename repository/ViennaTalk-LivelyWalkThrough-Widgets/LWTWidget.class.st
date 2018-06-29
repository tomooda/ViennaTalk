Class {
	#name : #LWTWidget,
	#superclass : #Morph,
	#instVars : [
		'name',
		'nameFont',
		'nameColor',
		'eventActionDict',
		'resizing'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #events }
LWTWidget >> actionSelectorsForEvent: aSymbol do: aBlock [
	self eventActionDict in: [ :actionDict | (actionDict at: aSymbol ifAbsent: [ #() ]) do: aBlock ]
]

{ #category : #events }
LWTWidget >> availableEventSelectors [
	^ self subclassResponsibility
]

{ #category : #operations }
LWTWidget >> changeName [
	(UIManager default request: 'Enter a new name' initialAnswer: self name) ifNotNil: [ :newName | self name: newName ]
]

{ #category : #operations }
LWTWidget >> changeNameColor [
	| dialog |
	dialog := ColorSelectorDialogWindow new
		title: 'Choose a color for name';
		selectedColor: self nameColor.
	self openModal: dialog.
	dialog cancelled
		ifFalse: [ self nameColor: dialog selectedColor ]
]

{ #category : #operations }
LWTWidget >> changeNameFont [
	self
		openModal:
			(FontChooser
				openWithWindowTitle: 'Choose a font for the name'
				for: self
				setSelector: #nameFont:
				getSelector: #nameFont)
]

{ #category : #events }
LWTWidget >> clearEvent: aSymbol [
	self eventActionDict removeKey: aSymbol ifAbsent: [  ]
]

{ #category : #defaults }
LWTWidget >> defaultName [
	^ self makeUniqueName
]

{ #category : #defaults }
LWTWidget >> defaultNameColor [
	^ self subclassResponsibility
]

{ #category : #defaults }
LWTWidget >> defaultNameFont [
	^ self subclassResponsibility
]

{ #category : #accessing }
LWTWidget >> director [
	| director |
	director := self.
	[ director isNil or: [ director isKindOf: LWTDirector ] ] whileFalse: [ director := director owner ].
	^ director
]

{ #category : #operations }
LWTWidget >> duplicateAndPlace [
	self duplicate
		changeName;
		top: self bottom;
		openInWorld
]

{ #category : #private }
LWTWidget >> edgeName: aPoint [
	| edge |
	edge := ''.
	(self left - aPoint x) abs < self edgePrecision
		ifTrue: [ edge := 'Left' , edge ]
		ifFalse: [ 
			(self right - aPoint x) abs < self edgePrecision
				ifTrue: [ edge := 'Right' , edge ] ].
	(self top - aPoint y) abs < self edgePrecision
		ifTrue: [ edge := 'Top' , edge ]
		ifFalse: [ 
			(self bottom - aPoint y) abs < self edgePrecision
				ifTrue: [ edge := 'Bottom' , edge ] ].
	^ edge
]

{ #category : #private }
LWTWidget >> edgePrecision [
	^ 10
]

{ #category : #events }
LWTWidget >> effectiveEventSelectors [
	^ eventActionDict keys asArray
]

{ #category : #events }
LWTWidget >> event: aSymbol [
	self director
		ifNotNil: [ :director | 
			(eventActionDict includesKey: aSymbol)
				ifFalse: [ ^ self ].
			director recordEvent: aSymbol at: self.
			self actionSelectorsForEvent: aSymbol do: [ :selector | director dispatchActionAt: selector ] ]
]

{ #category : #'event handling' }
LWTWidget >> handleMouseDown: aMouseEvent [
	aMouseEvent wasHandled: true.
	aMouseEvent yellowButtonPressed
		ifTrue: [ 
			self menu
				setInvokingView: self;
				invokeModal.
			^ true ].
	(self edgeName: aMouseEvent position)
		ifNotEmpty: [ :edge | 
			self perform: ('resize' , edge , ':') asSymbol with: aMouseEvent.
			^ true ].
	self currentHand grabMorph: self from: self owner.
	^ true
]

{ #category : #'event handling' }
LWTWidget >> handleMouseLeave: aMouseEvent [
	ActiveHand showTemporaryCursor: Cursor normal
]

{ #category : #'event handling' }
LWTWidget >> handleMouseMove: aMouseEvent [
	(self edgeName: aMouseEvent position)
		ifEmpty: [ ActiveHand showTemporaryCursor: Cursor normal ]
		ifNotEmpty: [ :edge | ActiveHand showTemporaryCursor: (Cursor perform: ('resize' , edge) asSymbol) ]
]

{ #category : #'event handling' }
LWTWidget >> handlesMouseDown: anEvent [
	"anEvent yellowButtonPressed
		ifTrue: [ ^ true ].
	(self edgeName: anEvent position) ifNotEmpty: [ :edge | ^ true ].
	^ super handlesMouseDown: anEvent"
	^true
]

{ #category : #'initialize-release' }
LWTWidget >> initialize [
	super initialize.
	eventActionDict := Dictionary new
]

{ #category : #private }
LWTWidget >> makeUniqueName [
	| basename random uniqueName |
	basename := self class name asString.
	random := Random new.
	[ 
	uniqueName := basename , (random nextInt: 999999) printString.
	(self director ifNil: [ World ])
		findDeepSubmorphThat: [ :m | m ~~ self and: [ m name = uniqueName ] ]
		ifAbsent: [ ^ uniqueName ] ] repeat
]

{ #category : #menus }
LWTWidget >> menu [
	| menu |
	menu := MenuMorph new
		defaultTarget: self;
		add: 'change name' translated target: self selector: #changeName;
		add: 'delete' translated target: self selector: #delete;
		add: 'duplicate' translated target: self selector: #duplicateAndPlace;
		addLine;
		add: 'change name font' translated target: self selector: #changeNameFont;
		add: 'change name color' translated target: self selector: #changeNameColor;
		yourself.
	^ menu
]

{ #category : #accessing }
LWTWidget >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
LWTWidget >> name: aString [
	World
		findDeepSubmorphThat: [ :m | (m isKindOf: LWTWidget) and: [ m ~~ self and: [ m name = aString ] ] ]
		ifAbsent: [ 
			name := aString.
			self changed.
			^ self ].
	self changeName
]

{ #category : #accessing }
LWTWidget >> nameColor [
	^ nameColor ifNil: [ nameColor := self defaultNameColor ]
]

{ #category : #accessing }
LWTWidget >> nameColor: aColor [
	nameColor := aColor.
	self changed
]

{ #category : #geometry }
LWTWidget >> nameExtent [
	^ self nameFont in: [ :font | (font widthOfString: self name) @ font height ]
]

{ #category : #accessing }
LWTWidget >> nameFont [
	^ nameFont ifNil: [ nameFont := self defaultNameFont ]
]

{ #category : #accessing }
LWTWidget >> nameFont: aFont [
	nameFont := aFont.
	self changed
]

{ #category : #geometry }
LWTWidget >> nameOffset [
	^ 3 @ 3
]

{ #category : #private }
LWTWidget >> resizeBottom: aMouseEvent [
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeBottomLeft: aMouseEvent [
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (newPoint x @ self top corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeBottomRight: aMouseEvent [
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: newPoint) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeLeft: aMouseEvent [
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (newPoint x @ self top corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeRight: aMouseEvent [
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeTop: aMouseEvent [
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (self left @ newPoint y corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeTopLeft: aMouseEvent [
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (newPoint corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #private }
LWTWidget >> resizeTopRight: aMouseEvent [
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (self left @ newPoint y corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : #events }
LWTWidget >> when: eventSymbol add: anActionSymbol beforeIndex: anInteger [
	(eventActionDict at: eventSymbol ifAbsentPut: [ OrderedCollection new ])
		in: [ :actions | actions add: anActionSymbol beforeIndex: (anInteger ifNil: [ actions size + 1 ]) ]
]
