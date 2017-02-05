parsers-definitions
extendedExplicitFunctionDefinition
	^ identifier trim , self typeVariableList , self parameterTypes
		, self identifierTypePairList
		,
			(((self operator: '==')
				, (expression / self isSubclassResponsibility / self isNotYetSpecified)) ==> #second)
		, ((self pre , expression) ==> #second) optional , ((self post , expression) ==> #second)