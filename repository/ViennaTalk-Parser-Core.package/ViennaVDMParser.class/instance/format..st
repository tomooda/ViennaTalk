parsing
format: aString
	| ast |
	ast := self document end / self statement end / self expression end parse: aString.
	^ ast isPetitFailure
		ifTrue: [ ast ]
		ifFalse: [ (self scanCommentsOn: aString)
				inject: ast format
				into: [ :source :posAndComment | 
					posAndComment key
						ifNil: [ posAndComment value , String cr , source ]
						ifNotNil: [ | char count commentString index |
							char := posAndComment key key.
							count := posAndComment key value.
							commentString := posAndComment value.
							index := 0.
							count timesRepeat: [ index := source indexOf: char startingAt: index + 1 ].
							(source copyFrom: 1 to: index) , commentString
								, (source copyFrom: index + 1 to: source size) ] ] ]