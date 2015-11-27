parsers-expressions-basics
recordConstructor
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			args := constructorAndArgs second.
			'(ViennaComposite type: ' , constructorName storeString , ' withAll: {' , (' . ' join: args) , '})' ]