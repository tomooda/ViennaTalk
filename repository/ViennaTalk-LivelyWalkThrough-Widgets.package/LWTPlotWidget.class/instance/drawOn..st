drawing
drawOn: aCanvas
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