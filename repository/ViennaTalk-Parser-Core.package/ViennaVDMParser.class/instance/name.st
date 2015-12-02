parsers-expressions-basics
name
	^ super name
		==> [ :array | 
			array isString
				ifTrue: [ ViennaNode label: 'LocalName' with: array ]
				ifFalse: [ ViennaNode label: 'GlobalName' withAll: array ] ]