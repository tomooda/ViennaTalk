Class {
	#name : #LWTPlotWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'value',
		'data',
		'dataBounds',
		'textFont',
		'lineWidth',
		'dotRadius'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #json }
LWTPlotWidget >> asJsonObject [
	^ super asJsonObject
		at: 'rawData' put: self rawData;
		at: 'textFont' put: (self fontToJsonObject: self textFont);
		at: 'lineWidth' put: self lineWidth;
		at: 'dotRadius' put: self dotRadius;
		yourself
]

{ #category : #events }
LWTPlotWidget >> availableEventSelectors [

	^ #( changed assigned )
]

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
	^ dataBounds
		ifNil: [ 
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
			minX @ minY corner: maxX @ maxY ]
]

{ #category : #enumerating }
LWTPlotWidget >> dataPointsDo: aBlock [
	data isNil
		ifTrue: [ ^ self ].
	data isNumber
		ifTrue: [ 
			aBlock value: 0 value: data.
			^ self ].
	(data isArray and: [ data size = 2 ])
		ifTrue: [ 
			aBlock value: data first value: data second.
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

{ #category : #accessing }
LWTPlotWidget >> dotRadius [
	^ dotRadius 
]

{ #category : #accessing }
LWTPlotWidget >> dotRadius: aNumber [
	dotRadius := aNumber.
	self changed
]

{ #category : #drawing }
LWTPlotWidget >> drawOn: aCanvas [
	| font dBounds originX originY scaleX scaleY offsetX offsetY x0 y0 x1 y1 p |
	font := TextStyle default defaultFont.
	aCanvas
		clipBy: self bounds
		during: [ :canvas | 
			canvas
				frameAndFillRectangle: self bounds
				fillColor: Color white
				borderWidth: 1
				borderColor: Color lightGray.
			super drawOn: canvas.
			dBounds := self dataBounds.
			dBounds width = 0
				ifTrue: [ dBounds := dBounds insetBy: -2 @ 0 ].
			dBounds height = 0
				ifTrue: [ dBounds := dBounds insetBy: 0 @ -2 ].
			originX := dBounds left.
			scaleX := (self bounds width - 10) asFloat / dBounds width asFloat.
			offsetX := self bounds left + 5.
			originY := dBounds bottom.
			scaleY := (self bounds height - 10) asFloat / dBounds height negated asFloat.
			offsetY := self bounds top + 5.
			x0 := (0.0 - originX) * scaleX + offsetX.
			y0 := (0.0 - originY) * scaleY + offsetY.
			x1 := self bounds center x.
			y1 := self bounds center y.
			(dBounds left < 0 and: [ dBounds right > 0 ])
				ifTrue: [ 
					x1 := x0.
					canvas
						line: x0 @ self bounds top
						to: x0 @ self bounds bottom
						width: 1
						color: Color darkGray ].
			(dBounds top < 0 and: [ dBounds bottom > 0 ])
				ifTrue: [ 
					y1 := y0.
					canvas
						line: self bounds left @ y0
						to: self bounds right @ y0
						width: 1
						color: Color darkGray ].
			canvas
				drawString: dBounds left printString
				at: bounds left @ y1
				font: font
				color: Color gray.
			canvas
				drawString: dBounds right printString
				at: (bounds right - (font widthOfString: dBounds right printString)) @ y1
				font: font
				color: Color gray.
			canvas
				drawString: dBounds bottom printString
				at: x1 @ (self bounds top)
				font: font
				color: Color gray.
			canvas
				drawString: dBounds top printString
				at: x1 @ (self bounds bottom - font height)
				font: font
				color: Color gray.
			p := nil.
			self
				dataPointsDo: [ :x :y | 
					(x notNil and: [ y notNil ])
						ifTrue: [ 
							| p0 |
							p0 := ((x - originX) * scaleX + offsetX) @ ((y - originY) * scaleY + offsetY).
							dotRadius > 0
								ifTrue: [ canvas fillOval: ((p0 x - dotRadius) @ (p0 y - dotRadius) extent: dotRadius @ dotRadius * 2) color: color ].
							p
								ifNotNil: [ 
									canvas
										line: p
										to: p0
										width: lineWidth
										color: color ].
							p := p0 ]
						ifFalse: [ p := nil ] ] ]
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

{ #category : #accessing }
LWTPlotWidget >> lineWidth [
	^ lineWidth
]

{ #category : #accessing }
LWTPlotWidget >> lineWidth: aNumber [
	lineWidth := aNumber.
	self changed
]

{ #category : #operations }
LWTPlotWidget >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'data bounds' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'set data bounds...' translated target: self selector: #setDataBounds;
						add: 'unset data bounds' translated target: self selector: #unsetDataBounds;
						yourself);
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

{ #category : #private }
LWTPlotWidget >> rawData [
	^ value
]

{ #category : #private }
LWTPlotWidget >> rawData: aString [
	value := aString.
	self
		data:
			([ ViennaReader new parse: aString ]
				on: Error
				do: [ :ex | nil ])
]

{ #category : #operations }
LWTPlotWidget >> setDataBounds [
	(UIManager default
		request: 'data bounds (min x, min y, max x, max y)'
		initialAnswer:
			(dataBounds
				ifNotNil: [ 
					dataBounds left printString , ', ' , dataBounds top printString , ', ' , dataBounds right printString , ', '
						, dataBounds bottom printString ]
				ifNil: [ '-1, -1, 1, 1' ])
		title: self name)
		ifNotNil: [ :quad | 
			[ 
			| stream reader left top right bottom |
			stream := quad trim readStream.
			reader := ViennaReader new.
			left := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			top := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			right := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			bottom := reader parseNumberOn: stream.
			dataBounds := left @ top corner: right @ bottom.
			self changed.
			^ true ]
				on: Error
				do: [ :ex | ^ false ] ]
]

{ #category : #operations }
LWTPlotWidget >> smallDot [
	dotRadius := 2.
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

{ #category : #operations }
LWTPlotWidget >> unsetDataBounds [
	dataBounds := nil.
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
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]
]
