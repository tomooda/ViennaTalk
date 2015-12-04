parsers-expressions-basics
name
	^ super name
		==> [ :stringOrPair | 
			stringOrPair isString
				ifTrue: [ stringOrPair ]
				ifFalse: [ '(' , stringOrPair first , ' at: ' , stringOrPair second storeString , ')' ] ]