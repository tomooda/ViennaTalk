accessing
dataBounds
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