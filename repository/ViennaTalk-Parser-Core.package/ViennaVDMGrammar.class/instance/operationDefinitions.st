parsers-definitions
operationDefinitions
	^ ((self reserved: 'operations') , (self accessOperationDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second