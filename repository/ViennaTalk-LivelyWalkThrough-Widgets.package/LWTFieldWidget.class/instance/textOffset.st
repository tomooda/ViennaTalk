geometry
textOffset
	^ 0
		@
			(self nameOffset y
				+
					(self showsName
						ifTrue: [ self nameExtent y + 3 ]
						ifFalse: [ 0 ]))