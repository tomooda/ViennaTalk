drawing
drawOn: aCanvas
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