parsers-expressions
recordConstructor
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			args := constructorAndArgs second.
			ViennaComposite constructorName: constructorName withAll: args ]