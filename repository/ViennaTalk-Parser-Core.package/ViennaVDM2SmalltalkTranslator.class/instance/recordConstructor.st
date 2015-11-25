parsers-expressions-basics
recordConstructor
	^ super recordConstructor
		==> [ :typeAndArgs | 
			| typeName args |
			typeName := typeAndArgs first.
			args := typeAndArgs second.
			'(ViennaComposite type: ' , typeName storeString , ' withAll: {' , (' . ' join: args) , '})' ]