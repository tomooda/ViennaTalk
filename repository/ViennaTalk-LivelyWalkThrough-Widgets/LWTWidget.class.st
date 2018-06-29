Class {
	#name : #LWTWidget,
	#superclass : #Morph,
	#instVars : [
		'name',
		'nameFont',
		'nameColor',
		'moveable',
		'showsName',
		'frozen'
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

{ #category : #accessing }
LWTWidget >> basename [
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

{ #category : #defaults }
LWTWidget >> defaultMoveable [
	^ true
]

{ #category : #defaults }
LWTWidget >> defaultName [
	^ self makeUniqueName
]

{ #category : #defaults }
LWTWidget >> defaultNameColor [
	^ Color lightGray
]

{ #category : #defaults }
LWTWidget >> defaultNameFont [
	^ TextStyle default defaultFont
]

{ #category : #defaults }
LWTWidget >> defaultShowsName [
	^ true
]

{ #category : #accessing }
LWTWidget >> director [
	| director |
	director := self.
	[ director isNil or: [ director isKindOf: LWTDirector ] ] whileFalse: [ director := director owner ].
	^ director
]

{ #category : #drawing }
LWTWidget >> drawHighlightedOn: aCanvas [
	self director
		ifNotNil: [ :d | 
			d
				selectedWidgetsDo: [ :morph | 
					self == morph
						ifTrue: [ aCanvas frameRectangle: (self bounds insetBy: -1) width: 3 color: Color blue ] ] ]
]

{ #category : #drawing }
LWTWidget >> drawOn: aCanvas [
	self showsName
		ifTrue: [ 
			aCanvas
				drawString: self name
				at: self position + self nameOffset
				font: self nameFont
				color: self nameColor ].
	self drawHighlightedOn: aCanvas
]

{ #category : #operations }
LWTWidget >> duplicateAndPlace [
	^ (UIManager default request: 'Enter a new name' initialAnswer: self name)
		ifNotNil: [ :newName | 
			| duplicate |
			duplicate := self duplicate
				name: newName;
				top: self bottom.
			self director addMorph: duplicate.
			duplicate ]
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
LWTWidget >> event: aSymbol [
	self director ifNotNil: [ :director | director execEvent: aSymbol at: self name ]
]

{ #category : #private }
LWTWidget >> freeze [
	frozen := true
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
	self moveable = true
		ifTrue: [ 
			(self edgeName: aMouseEvent position)
				ifNotEmpty: [ :edge | 
					self perform: ('resize' , edge , ':') asSymbol with: aMouseEvent.
					^ true ].
			self currentHand grabMorph: self from: self owner ].
	^ true
]

{ #category : #'event handling' }
LWTWidget >> handleMouseLeave: aMouseEvent [
	ActiveHand showTemporaryCursor: Cursor normal
]

{ #category : #'event handling' }
LWTWidget >> handleMouseMove: aMouseEvent [
	self moveable = true
		ifTrue: [ 
			(self edgeName: aMouseEvent position)
				ifEmpty: [ ActiveHand showTemporaryCursor: Cursor normal ]
				ifNotEmpty: [ :edge | ActiveHand showTemporaryCursor: (Cursor perform: ('resize' , edge) asSymbol) ] ]
]

{ #category : #'event handling' }
LWTWidget >> handlesMouseDown: anEvent [
	^ frozen not
]

{ #category : #operations }
LWTWidget >> hideName [
	showsName := false.
	self changed
]

{ #category : #'initialize-release' }
LWTWidget >> initialize [
	super initialize.
	moveable := self defaultMoveable.
	showsName := self defaultShowsName.
	frozen := false
]

{ #category : #private }
LWTWidget >> makeUniqueName [
	| prefix random uniqueName |
	prefix := self basename.
	random := Random new.
	[ 
	uniqueName := prefix , (random nextInt: 999999) printString.
	(self director ifNil: [ World ])
		findDeepSubmorphThat: [ :m | m ~~ self and: [ (m isKindOf: LWTWidget) and: [ m name = uniqueName ] ] ]
		ifAbsent: [ ^ uniqueName ] ] repeat
]

{ #category : #menus }
LWTWidget >> menu [
	| menu |
	menu := MenuMorph new
		addTitle: self name;
		defaultTarget: self;
		add: 'delete' translated target: self selector: #delete;
		add: 'duplicate' translated target: self selector: #duplicateAndPlace;
		add:
				(self moveable
						ifTrue: [ 'fix position' translated ]
						ifFalse: [ 'make moveable' ])
			target: self
			selector: #toggleMoveable;
		addLine;
		add: 'name' subMenu: self nameMenu yourself.
	^ menu
]

{ #category : #accessing }
LWTWidget >> moveable [
	^ moveable
]

{ #category : #accessing }
LWTWidget >> moveable: aBoolean [
	moveable := aBoolean = true
]

{ #category : #accessing }
LWTWidget >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
LWTWidget >> name: aString [
	self director
		ifNotNil: [ :director | 
			director
				findDeepSubmorphThat: [ :m | (m isKindOf: LWTWidget) and: [ m ~~ self and: [ m name = aString ] ] ]
				ifAbsent: [ 
					name := aString.
					self changed.
					^ self ].
			self changeName ]
		ifNil: [ 
			name := aString.
			self changed ]
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

{ #category : #menus }
LWTWidget >> nameMenu [
	| menu |
	menu := MenuMorph new.
	menu
		defaultTarget: self;
		add: 'change name' translated target: self selector: #changeName.
	self showsName = true
		ifTrue: [ 
			menu
				add: 'hide' translated target: self selector: #hideName;
				add: 'change name font' translated target: self selector: #changeNameFont;
				add: 'change name color' translated target: self selector: #changeNameColor ]
		ifFalse: [ menu add: 'show' translated target: self selector: #showName ].
	^ menu
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

{ #category : #operations }
LWTWidget >> showName [
	showsName := true.
	self changed
]

{ #category : #testing }
LWTWidget >> showsName [
	^ showsName = true
]

{ #category : #operations }
LWTWidget >> toggleMoveable [
	self moveable: self moveable not
]
