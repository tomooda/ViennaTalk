parsers-definitions
operationDefinitions
	^ (self operations , (self accessOperationDefinition separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second