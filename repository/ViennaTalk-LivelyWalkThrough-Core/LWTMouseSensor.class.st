Class {
	#name : 'LWTMouseSensor',
	#superclass : 'LWTWidget',
	#instVars : [
		'basename',
		'point',
		'borderColor',
		'borderWidth'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'instance creation' }
LWTMouseSensor class >> area [
	^ self new
		basename: 'Area';
		extent: 100 @ 100;
		color: Color transparent;
		borderColor: Color gray;
		thinBorder;
		yourself
]

{ #category : 'instance creation' }
LWTMouseSensor class >> button [
	^ self new
		basename: 'Button';
		extent: 200 @ 30;
		color: Color lightGray;
		nameColor: Color black;
		borderColor: Color darkGray;
		thickBorder;
		yourself
]

{ #category : 'instance creation' }
LWTMouseSensor class >> pad [
	^ self new
		basename: 'MousePad';
		extent: 200 @ 200;
		color: (Color lightGray alpha: 0.5);
		borderColor: Color gray;
		thinBorder;
		yourself
]

{ #category : 'json' }
LWTMouseSensor >> asJsonObject [
	^ super asJsonObject
		at: 'basename' put: self basename;
		at: 'point' put: (self pointToJsonObject: self point);
		at: 'color' put: (self colorToJsonObject: self color);
		at: 'borderColor' put: (self colorToJsonObject: self borderColor);
		at: 'borderWidth' put: self borderWidth;
		yourself
]

{ #category : 'events' }
LWTMouseSensor >> availableEventSelectors [
	^ #(clicked doubleClicked up entered left moved)
]

{ #category : 'accessing' }
LWTMouseSensor >> basename [
	^ basename ifNil: [ basename := self defaultBasename ]
]

{ #category : 'accessing' }
LWTMouseSensor >> basename: aString [
	basename := aString
]

{ #category : 'accessing' }
LWTMouseSensor >> borderColor [
	^ borderColor
]

{ #category : 'accessing' }
LWTMouseSensor >> borderColor: aColor [
	borderColor := aColor.
	self changed
]

{ #category : 'accessing' }
LWTMouseSensor >> borderWidth [
	^ borderWidth
]

{ #category : 'accessing' }
LWTMouseSensor >> borderWidth: aNumber [
	borderWidth := aNumber.
	self changed
]

{ #category : 'operations' }
LWTMouseSensor >> changeBorderColor [

	| dialog |
	dialog := ColorSelectorDialogWindow new
		          title: 'Choose a border color for the sensor';
		          selectedColor: self borderColor.
	dialog openModal.
	dialog cancelled ifFalse: [ self borderColor: dialog selectedColor ]
]

{ #category : 'operations' }
LWTMouseSensor >> changeColor [

	| dialog |
	dialog := ColorSelectorDialogWindow new
		          title: 'Choose a color for the sensor';
		          selectedColor: self color.
	dialog openModal.
	dialog cancelled ifFalse: [ self color: dialog selectedColor ]
]

{ #category : 'event handling' }
LWTMouseSensor >> click: aMouseEvent [
	point := aMouseEvent position.
	self event: #clicked
]

{ #category : 'defaults' }
LWTMouseSensor >> defaultBasename [
	^ 'MouseSensor'
]

{ #category : 'defaults' }
LWTMouseSensor >> defaultBorderColor [
	^ Color blue
]

{ #category : 'defaults' }
LWTMouseSensor >> defaultBorderWidth [
	^ 3
]

{ #category : 'defaults' }
LWTMouseSensor >> defaultColor [
	^ Color transparent
]

{ #category : 'defaults' }
LWTMouseSensor >> defaultExtent [
	^ 100 @ 100
]

{ #category : 'event handling' }
LWTMouseSensor >> doubleClick: aMouseEvent [
	point := aMouseEvent position.
	self event: #doubleClicked
]

{ #category : 'drawing' }
LWTMouseSensor >> drawOn: aCanvas [
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: self color
		borderWidth: self borderWidth
		borderColor: self borderColor.
	super drawOn: aCanvas
]

{ #category : 'event handling' }
LWTMouseSensor >> handleMouseDown: aMouseEvent [
	aMouseEvent hand waitForClicksOrDrag: self event: aMouseEvent.
	^ super handleMouseDown: aMouseEvent
]

{ #category : 'event handling' }
LWTMouseSensor >> handleMouseEnter: aMouseEvent [
	point := aMouseEvent position.
	self event: #entered
]

{ #category : 'event handling' }
LWTMouseSensor >> handleMouseLeave: aMouseEvent [
	point := aMouseEvent position.
	self event: #left
]

{ #category : 'event handling' }
LWTMouseSensor >> handleMouseMove: aMouseEvent [
	point := aMouseEvent position.
	self event: #moved.
	^ super handleMouseMove: aMouseEvent
]

{ #category : 'event handling' }
LWTMouseSensor >> handleMouseUp: aMouseEvent [
	point := aMouseEvent position.
	self event: #up
]

{ #category : 'initialize-release' }
LWTMouseSensor >> initialize [
	super initialize.
	self borderColor: self defaultBorderColor.
	self borderWidth: self defaultBorderWidth
]

{ #category : 'menus' }
LWTMouseSensor >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'change color' translated target: self selector: #changeColor;
		add: 'border' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'change border color' translated target: self selector: #changeBorderColor;
						add: 'no border' translated target: self selector: #noBorder;
						add: 'thin' translated target: self selector: #thinBorder;
						add: 'thick' translated target: self selector: #thickBorder;
						yourself);
		yourself.
	^ menu
]

{ #category : 'operations' }
LWTMouseSensor >> noBorder [
	self borderWidth: 0
]

{ #category : 'private' }
LWTMouseSensor >> point [
	^ point
]

{ #category : 'private' }
LWTMouseSensor >> point: aPoint [
	point := aPoint
]

{ #category : 'operations' }
LWTMouseSensor >> thickBorder [
	self borderWidth: 3
]

{ #category : 'operations' }
LWTMouseSensor >> thinBorder [
	self borderWidth: 1
]

{ #category : 'accessing' }
LWTMouseSensor >> value [
	^ 'mk_(' , point x printString , ',' , point y printString , ')'
]

{ #category : 'accessing' }
LWTMouseSensor >> value: aString [
	^ self director abort: '[' , self name , '] is readonly widget.' , aString
]
