Class {
	#name : 'LWTWidget',
	#superclass : 'Morph',
	#instVars : [
		'name',
		'nameFont',
		'nameColor',
		'moveable',
		'showsName',
		'frozen'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core-Widgets',
	#package : 'ViennaTalk-LivelyWalkThrough-Core',
	#tag : 'Widgets'
}

{ #category : 'json' }
LWTWidget class >> attributeFromJsonObject: anObject [
	anObject isDictionary
		ifFalse: [ ^ anObject ].
	anObject
		at: 'storeString'
		ifPresent: [ :storeString | 
			[ ^ OpalCompiler new
				source: storeString;
				evaluate ]
				on: Error
				do: [ :ex | 
					^ anObject
						at: 'onError'
						ifPresent: [ :alternative | 
							[ OpalCompiler new
								source: alternative;
								evaluate ]
								on: Error
								do: [ :ex2 | nil ] ]
						ifAbsent: [  ] ] ].
	^ anObject
]

{ #category : 'json' }
LWTWidget class >> fromJsonObject: aDictionary on: aLWTDirector [
	| widget |
	widget := (Smalltalk at: (aDictionary at: '_class') asSymbol) new.
	aDictionary
		keysAndValuesDo: [ :key :value | 
			key first ~= $_
				ifTrue: [ 
					| selector |
					selector := (key , ':') asSymbol.
					(widget respondsTo: selector)
						ifTrue: [ widget perform: selector with: (self attributeFromJsonObject: value) ] ] ].
	aLWTDirector addMorphBack: widget.
	widget position: (self attributeFromJsonObject: (aDictionary at: '_relativePosition')) + aLWTDirector position.
	^ widget
]

{ #category : 'json' }
LWTWidget >> asJsonObject [
	^ Dictionary new
		at: '_class' put: self class name asString;
		at: '_relativePosition' put: (self pointToJsonObject: self position - self owner position);
		at: 'extent' put: (self pointToJsonObject: self extent);
		at: 'name' put: self name;
		at: 'nameFont' put: (self fontToJsonObject: self nameFont);
		at: 'nameColor' put: (self colorToJsonObject: self nameColor);
		at: 'moveable' put: self moveable;
		at: 'showsName' put: self showsName;
		yourself
]

{ #category : 'events' }
LWTWidget >> availableEventSelectors [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
LWTWidget >> basename [
	^ self subclassResponsibility
]

{ #category : 'operations' }
LWTWidget >> changeName [
	(UIManager default request: 'Enter a new name' initialAnswer: self name) ifNotNil: [ :newName | self name: newName ]
]

{ #category : 'operations' }
LWTWidget >> changeNameColor [

	| dialog |
	dialog := ColorSelectorDialogWindow new
		          title: 'Choose a color for name';
		          selectedColor: self nameColor.
	dialog openModal.
	dialog cancelled ifFalse: [ self nameColor: dialog selectedColor ]
]

{ #category : 'operations' }
LWTWidget >> changeNameFont [

	FontChooser
		openModalWithTitle: 'Choose a font for the name'
		initialFont: self nameFont
		onAcceptDo: [ :f | self nameFont: f ]
]

{ #category : 'json' }
LWTWidget >> colorToJsonObject: aColor [
	^ Dictionary new
		at: 'storeString' put: aColor storeString;
		yourself
]

{ #category : 'defaults' }
LWTWidget >> defaultExtent [
	^ self subclassResponsibility
]

{ #category : 'defaults' }
LWTWidget >> defaultMoveable [
	^ true
]

{ #category : 'defaults' }
LWTWidget >> defaultName [
	^ self makeUniqueName
]

{ #category : 'defaults' }
LWTWidget >> defaultNameColor [
	^ Color lightGray
]

{ #category : 'defaults' }
LWTWidget >> defaultNameFont [
	^ ViennaLauncher font
]

{ #category : 'defaults' }
LWTWidget >> defaultShowsName [
	^ true
]

{ #category : 'accessing' }
LWTWidget >> director [
	| director |
	director := self.
	[ director isNil or: [ director isKindOf: LWTDirector ] ] whileFalse: [ director := director owner ].
	^ director
]

{ #category : 'drawing' }
LWTWidget >> drawHighlightedOn: aCanvas [
	self director
		ifNotNil: [ :d | 
			d
				selectedWidgetsDo: [ :morph | 
					self == morph
						ifTrue: [ aCanvas frameRectangle: (self bounds insetBy: -1) width: 3 color: Color blue ] ] ]
]

{ #category : 'drawing' }
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

{ #category : 'operations' }
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

{ #category : 'private' }
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

{ #category : 'private' }
LWTWidget >> edgePrecision [
	^ 10
]

{ #category : 'events' }
LWTWidget >> event: aSymbol [
	self director ifNotNil: [ :director | director execEvent: aSymbol at: self name ]
]

{ #category : 'json' }
LWTWidget >> fontToJsonObject: aFont [
	^ Dictionary new
		at: 'storeString' put: aFont storeString;
		at: 'onError' put: 'TextStyle default defaultFont';
		yourself
]

{ #category : 'private' }
LWTWidget >> freeze [
	frozen := true
]

{ #category : 'event handling' }
LWTWidget >> handleMouseDown: aMouseEvent [
	aMouseEvent wasHandled: true.
	aMouseEvent yellowButtonPressed
		ifTrue: [ 
			(aMouseEvent shiftPressed
				ifTrue: [ self smalltalkMenu ]
				ifFalse: [ self menu ])
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

{ #category : 'event handling' }
LWTWidget >> handleMouseLeave: aMouseEvent [

	self world activeHand showTemporaryCursor: Cursor normal
]

{ #category : 'event handling' }
LWTWidget >> handleMouseMove: aMouseEvent [

	self moveable = true ifTrue: [
		(self edgeName: aMouseEvent position)
			ifEmpty: [
			self world activeHand showTemporaryCursor: Cursor normal ]
			ifNotEmpty: [ :edge |
				self world activeHand showTemporaryCursor:
					(Cursor perform: ('resize' , edge) asSymbol) ] ]
]

{ #category : 'event handling' }
LWTWidget >> handlesMouseDown: anEvent [
	^ frozen not
]

{ #category : 'operations' }
LWTWidget >> hideName [
	showsName := false.
	self changed
]

{ #category : 'initialize-release' }
LWTWidget >> initialize [
	super initialize.
	moveable := self defaultMoveable.
	showsName := self defaultShowsName.
	frozen := false.
	self extent: self defaultExtent
]

{ #category : 'private' }
LWTWidget >> makeUniqueName [

	| prefix random uniqueName |
	prefix := self basename.
	random := Random new.
	[
	uniqueName := prefix , (random nextInteger: 999999) printString.
	(self director ifNil: [ self world ])
		ifNil: [ ^ uniqueName ]
		ifNotNil: [ :world |
			world
				findDeepSubmorphThat: [ :m |
					m ~~ self and: [
						(m isKindOf: LWTWidget) and: [ m name = uniqueName ] ] ]
				ifAbsent: [ ^ uniqueName ] ] ] repeat
]

{ #category : 'menus' }
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
		add: 'move to front end' translated target: self selector: #moveFrontEnd;
		add: 'move front' translated target: self selector: #moveFront;
		add: 'move back' translated target: self selector: #moveBack;
		add: 'move to back end' translated target: self selector: #moveBackEnd;
		addLine;
		add: 'name' subMenu: self nameMenu yourself.
	^ menu
]

{ #category : 'operations' }
LWTWidget >> moveBack [
	self owner
		ifNotNil: [ self owner privateAddMorph: self atIndex: ((self owner submorphIndexOf: self) + 2 min: self owner submorphs size + 1) ]
]

{ #category : 'operations' }
LWTWidget >> moveBackEnd [
	self owner ifNotNil: [ self owner addMorphBack: self ]
]

{ #category : 'operations' }
LWTWidget >> moveFront [
	self owner ifNotNil: [ self owner privateAddMorph: self atIndex: ((self owner submorphIndexOf: self) - 1 max: 1) ]
]

{ #category : 'operations' }
LWTWidget >> moveFrontEnd [
	self owner ifNotNil: [ self owner addMorphFront: self ]
]

{ #category : 'accessing' }
LWTWidget >> moveable [
	^ moveable
]

{ #category : 'private' }
LWTWidget >> moveable: aBoolean [
	moveable := aBoolean = true
]

{ #category : 'accessing' }
LWTWidget >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
LWTWidget >> nameColor [
	^ nameColor ifNil: [ nameColor := self defaultNameColor ]
]

{ #category : 'accessing' }
LWTWidget >> nameColor: aColor [
	nameColor := aColor.
	self changed
]

{ #category : 'geometry' }
LWTWidget >> nameExtent [
	^ self nameFont in: [ :font | (font widthOfString: self name) @ font height ]
]

{ #category : 'accessing' }
LWTWidget >> nameFont [
	^ nameFont ifNil: [ nameFont := self defaultNameFont ]
]

{ #category : 'accessing' }
LWTWidget >> nameFont: aFont [
	nameFont := aFont.
	self changed
]

{ #category : 'menus' }
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

{ #category : 'geometry' }
LWTWidget >> nameOffset [
	^ 3 @ 3
]

{ #category : 'json' }
LWTWidget >> pointToJsonObject: aPoint [
	^ Dictionary new
		at: 'storeString' put: aPoint storeString;
		yourself
]

{ #category : 'private' }
LWTWidget >> resizeBottom: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (self topLeft corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeBottomLeft: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (newPoint x @ self top corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeBottomRight: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds: (self topLeft corner: newPoint) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeLeft: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (newPoint x @ self top corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeRight: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (self topLeft corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeTop: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (self left @ newPoint y corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeTopLeft: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds: (newPoint corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'private' }
LWTWidget >> resizeTopRight: aMouseEvent [

	| handle |
	handle := HandleMorph new forEachPointDo: [ :p |
			          | newPoint |
			          newPoint := handle owner position.
			          handle position: newPoint.
			          self bounds:
				          (self left @ newPoint y corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping
]

{ #category : 'operations' }
LWTWidget >> showName [
	showsName := true.
	self changed
]

{ #category : 'accessing' }
LWTWidget >> showsName [
	^ showsName
]

{ #category : 'private' }
LWTWidget >> showsName: aBoolean [
	showsName := aBoolean = true
]

{ #category : 'menus' }
LWTWidget >> smalltalkMenu [
	| menu |
	menu := MenuMorph new
		addTitle: self name;
		defaultTarget: self;
		add: 'inspect' translated target: self selector: #inspect;
		yourself.
	^ menu
]

{ #category : 'operations' }
LWTWidget >> toggleMoveable [
	self moveable: self moveable not
]
