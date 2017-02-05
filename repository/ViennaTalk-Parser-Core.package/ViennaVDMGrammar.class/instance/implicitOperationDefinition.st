parsers-definitions
implicitOperationDefinition
	^ identifier trim , self parameterTypes
		, (self identifierTypePairList optional ==> [ :list | list ifNil: [ Array new ] ])
		, self implicitOperationBody