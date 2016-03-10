drawing
drawOn: aCanvas
	form
		ifNil: [ 
			aCanvas
				frameAndFillRectangle: self bounds
				fillColor: Color transparent
				borderWidth: 2
				borderColor: Color black ]
		ifNotNil: [ 
			| scale |
			scale := self extent / form extent.
			aCanvas
				paintImage:
					(form
						magnifyBy:
							(scale x asFloat > scale y asFloat
								ifTrue: [ scale y asFloat ]
								ifFalse: [ scale x asFloat ]))
				at: self position ].
	super drawOn: aCanvas