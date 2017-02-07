parsers-definitions
extendedExplicitOperationDefinition
	^ identifier trim , self parameterTypes
		, self identifierTypePairList optional
		, (((self operator: '==') , self operationBody) ==> #second)
		, self externals optional
		, ((self pre , expression) ==> #second) optional
		, ((self post , expression) ==> #second) , self exceptions optional