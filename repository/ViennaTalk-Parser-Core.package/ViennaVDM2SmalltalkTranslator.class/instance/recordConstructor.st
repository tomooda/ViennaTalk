parsers-expressions-basics
recordConstructor
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			args := constructorAndArgs second.
			'(ViennaComposite constructorName: ' , constructorName storeString , ' withAll: {' , (' . ' join: args) , '})' ]