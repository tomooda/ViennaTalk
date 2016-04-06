parsers-expressions
recordConstructor
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			constructorName isArray
				ifTrue: [ constructorName := '`' join: constructorName ].
			args := constructorAndArgs second.
			ViennaComposite constructorName: constructorName withAll: args ]