Class {
	#name : #LWTPlotWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'value',
		'data',
		'textFont',
		'lineWidth',
		'dotRadius'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #accessing }
LWTPlotWidget >> basename [
	^ 'Plot' copy
]

{ #category : #operations }
LWTPlotWidget >> bigDot [
	dotRadius := 4
	self changed
]

{ #category : #operations }
LWTPlotWidget >> changeColor [
	| dialog |
	dialog := ColorSelectorDialogWindow new
		title: 'Choose a color for the sensor';
		selectedColor: self color.
	self openModal: dialog.
	dialog cancelled
		ifFalse: [ self color: dialog selectedColor ]
]

{ #category : #operations }
LWTPlotWidget >> changeTextFont [
	self
		openModal:
			(FontChooser
				openWithWindowTitle: 'Choose a font for the text'
				for: self
				setSelector: #textFont:
				getSelector: #textFont)
]

{ #category : #accessing }
LWTPlotWidget >> data: anArrayOfNumber [
	anArrayOfNumber isNumber
		ifTrue: [ 
			data := anArrayOfNumber.
			^ self ].
	anArrayOfNumber isCollection
		ifTrue: [ 
			anArrayOfNumber isDictionary
				ifTrue: [ 
					| d |
					d := Dictionary new.
					anArrayOfNumber
						keysAndValuesDo: [ :key :value | 
							(key isNumber and: [ value isNumber ])
								ifTrue: [ d at: key put: value ] ].
					data := d ]
				ifFalse: [ 
					data := anArrayOfNumber
						collect: [ :e | 
							(e isNumber or: [ e isArray and: [ e size = 2 ] ])
								ifTrue: [ e ]
								ifFalse: [ nil ] ] ].
			^ self ].
	data := nil
]

{ #category : #accessing }
LWTPlotWidget >> dataBounds [
	| minX minY maxX maxY |
	minX := nil.
	minY := nil.
	maxX := nil.
	maxY := nil.
	self
		dataPointsDo: [ :x :y | 
			x
				ifNotNil: [ 
					(minX isNil or: [ x < minX ])
						ifTrue: [ minX := x ].
					(maxX isNil or: [ x > maxX ])
						ifTrue: [ maxX := x ] ].
			y
				ifNotNil: [ 
					(minY isNil or: [ y < minY ])
						ifTrue: [ minY := y ].
					(maxY isNil or: [ y > maxY ])
						ifTrue: [ maxY := y ] ] ].
	(minX isNil or: [ maxX isNil ])
		ifTrue: [ 
			minX := -1.
			maxX := 1 ].
	(minY isNil or: [ maxY isNil ])
		ifTrue: [ 
			minY := -1.
			maxY := 1 ].
	^ minX @ minY corner: maxX @ maxY
]

{ #category : #enumerating }
LWTPlotWidget >> dataPointsDo: aBlock [
	data isNil
		ifTrue: [ ^ self ].
	data isNumber
		ifTrue: [ 
			aBlock value: 0 value: data.
			^ self ].
	(data isSequenceable and: [ data allSatisfy: [ :e | e isArray ] ])
		ifTrue: [ 
			data do: [ :e | aBlock value: e first value: e second ].
			^ self ].
	data keysAndValuesDo: aBlock.
	^ self
]

{ #category : #defaults }
LWTPlotWidget >> defaultColor [
	^ Color blue
]

{ #category : #defaults }
LWTPlotWidget >> defaultData [
	^ Array new
]

{ #category : #defaults }
LWTPlotWidget >> defaultDotRadius [
	^ 4
]

{ #category : #defaults }
LWTPlotWidget >> defaultExtent [
	^ 200 @ 200
]

{ #category : #defaults }
LWTPlotWidget >> defaultLineWidth [
	^ 3
]

{ #category : #defaults }
LWTPlotWidget >> defaultTextFont [
	^ TextStyle default defaultFont
]

{ #category : #defaults }
LWTPlotWidget >> defaultValue [
	^ String new
]

{ #category : #drawing }
LWTPlotWidget >> drawOn: aCanvas [
	| dataBounds originX originY scaleX scaleY offsetX offsetY p |
	aCanvas fillRectangle: self bounds color: Color white.
	super drawOn: aCanvas.
	dataBounds := self dataBounds.
	dataBounds width = 0
		ifTrue: [ dataBounds := dataBounds insetBy: -2 @ 0 ].
	dataBounds height = 0
		ifTrue: [ dataBounds := dataBounds insetBy: 0 @ -2 ].
	originX := dataBounds left.
	scaleX := (self bounds width - 10) asFloat / dataBounds width asFloat.
	offsetX := self bounds left + 5.
	originY := dataBounds bottom.
	scaleY := (self bounds height - 10) asFloat / dataBounds height negated asFloat.
	offsetY := self bounds top + 5.
	p := nil.
	self
		dataPointsDo: [ :x :y | 
			(x notNil and: [ y notNil ])
				ifTrue: [ 
					| p0 |
					p0 := ((x - originX) * scaleX + offsetX) @ ((y - originY) * scaleY + offsetY).
					dotRadius > 0
						ifTrue: [ aCanvas fillOval: ((p0 x - dotRadius) @ (p0 y - dotRadius) extent: dotRadius @ dotRadius * 2) color: color ].
					p
						ifNotNil: [ 
							aCanvas
								line: p
								to: p0
								width: lineWidth
								color: color ].
					p := p0 ]
				ifFalse: [ p := nil ] ]
]

{ #category : #'initialize-release' }
LWTPlotWidget >> initialize [
	super initialize.
	value := self defaultValue.
	data := self defaultData.
	dotRadius := self defaultDotRadius.
	color := self defaultColor.
	lineWidth := self defaultLineWidth.
	textFont := self defaultTextFont
]

{ #category : #operations }
LWTPlotWidget >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'change color' translated target: self selector: #changeColor;
		add: 'line' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'no line' translated target: self selector: #noLine;
						add: 'thin line' translated target: self selector: #thinLine;
						add: 'thick line' translated target: self selector: #thickLine;
						yourself);
		add: 'dot' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'no dot' translated target: self selector: #noDot;
						add: 'small dot' translated target: self selector: #smallDot;
						add: 'big dot' translated target: self selector: #bigDot;
						yourself);
		yourself.
	^ menu
]

{ #category : #operations }
LWTPlotWidget >> noDot [
	dotRadius := 0.
	self changed
]

{ #category : #operations }
LWTPlotWidget >> noLine [
	lineWidth := 0.
	self changed
]

{ #category : #operations }
LWTPlotWidget >> smallDot [
	dotRadius := 2
	self changed
]

{ #category : #accessing }
LWTPlotWidget >> textFont [
	^ textFont ifNil: [ textFont := self defaultTextFont ]
]

{ #category : #accessing }
LWTPlotWidget >> textFont: aFont [
	textFont := aFont.
	self changed
]

{ #category : #operations }
LWTPlotWidget >> thickLine [
	lineWidth := 3.
	self changed
]

{ #category : #operations }
LWTPlotWidget >> thinLine [
	lineWidth := 1.
	self changed
]

{ #category : #accessing }
LWTPlotWidget >> value [
	^ value
]

{ #category : #accessing }
LWTPlotWidget >> value: aVDMValue [
	| oldValue |
	oldValue := value.
	value := aVDMValue.
	self
		data:
			([ ViennaReader new parse: aVDMValue ]
				on: Error
				do: [ :ex | nil ]).
	value ~= oldValue
		ifTrue: [ 
			self changed.
			self event: #changed ]
]
