parsers-definitions
implicitFunctionDefinition
	^ identifier trim , self typeVariableList , self parameterTypes
		, self identifierTypePairList , ((self pre , expression) ==> #second) optional
		, ((self post , expression) ==> #second)