parsing
format: aString width: anInteger
	| ast |
	ast := self parse: aString.
	^ ast isPetitFailure
		ifTrue: [ ast ]
		ifFalse: [ 
			(self scanCommentsOn: aString)
				inject: (ast formatWidth: anInteger)
				into: [ :source :posAndComment | 
					posAndComment key
						ifNil: [ posAndComment value , source ]
						ifNotNil: [ 
							| char count commentString index |
							char := posAndComment key key.
							count := posAndComment key value.
							commentString := posAndComment value.
							index := 0.
							count timesRepeat: [ index := source indexOf: char startingAt: index + 1 ].
							(source copyFrom: 1 to: index) , commentString , (source copyFrom: index + 1 to: source size) ] ] ]