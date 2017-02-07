parsers-definitions
implicitOperationDefinition
	^ identifier trim , self parameterTypes
		, self identifierTypePairList optional , self implicitOperationBody