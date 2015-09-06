drawing
drawOn: aCanvas
	| low high left middle right |
	low := (self bounds bottom * 0.8 + (self bounds top * 0.2)) asInteger.
	high := (self bounds bottom * 0.2 + (self bounds top * 0.8)) asInteger.
	left := (self bounds left * 0.8 + (self bounds right * 0.2)) asInteger.
	right := (self bounds left * 0.2 + (self bounds right * 0.8)) asInteger.
	middle := (self bounds left * 0.4 + (self bounds right * 0.6)) asInteger.
	super drawOn: aCanvas.
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color transparent
		borderWidth: 1
		borderColor: Color red.
	value odd
		ifTrue: [ 
			aCanvas
				line: left @ high
				to: left @ low
				width: 2
				color: Color black.
			aCanvas
				line: left @ low
				to: middle @ low
				width: 2
				color: Color black.
			aCanvas
				line: middle @ low
				to: middle @ high
				width: 2
				color: Color black.
			aCanvas
				line: middle @ high
				to: right @ high
				width: 2
				color: Color black ]
		ifFalse: [ 
			aCanvas
				line: left @ low
				to: left @ high
				width: 2
				color: Color black.
			aCanvas
				line: left @ high
				to: middle @ high
				width: 2
				color: Color black.
			aCanvas
				line: middle @ high
				to: middle @ low
				width: 2
				color: Color black.
			aCanvas
				line: middle @ low
				to: right @ low
				width: 2
				color: Color black ]