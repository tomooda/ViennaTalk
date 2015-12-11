parsers-definitions
explicitFunctionDefinition
	^ (identifier , self typeVariableList optional , colon , (self partialFunctionType / self totalFunctionType) trim
		, identifier , self parametersList , (self operator: '==')
		,
			(expression / ((self reserved: 'is') , (self reserved: 'subclass') , (self reserved: 'responsibility'))
				/ ((self reserved: 'is') / (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified')))
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional
		, (((self reserved: 'measure') , name) ==> #second) optional)
		==> [ :array | 
			array first = array fifth
				ifTrue: [ 
					{(array first).
					(array second ifNil: [ #() ]).
					(array fourth).
					(array fifth).
					(array sixth).
					(array eighth).
					(array ninth).
					(array at: 10).
					(array at: 11)} ]
				ifFalse: [ PPFailure message: 'function name mismatch: ' , array first , ', ' , array fifth ] ]