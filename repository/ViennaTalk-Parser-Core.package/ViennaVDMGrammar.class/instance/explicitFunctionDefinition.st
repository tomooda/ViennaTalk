parsers-definitions
explicitFunctionDefinition
	^ (identifier , self typeVariableList , colon , self functionType trim , identifier , self parametersList
		, (self operator: '==') , (expression / self isSubclassResponsibility / self isNotYetSpecified)
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional
		, (((self reserved: 'measure') , name) ==> #second) optional)
		==> [ :array | 
			array first = array fifth
				ifTrue: [ 
					{(array first).
					(array second).
					(array fourth).
					(array fifth).
					(array sixth).
					(array eighth).
					(array ninth).
					(array at: 10).
					(array at: 11)} ]
				ifFalse: [ PPFailure message: 'function name mismatch: ' , array first , ', ' , array fifth ] ]