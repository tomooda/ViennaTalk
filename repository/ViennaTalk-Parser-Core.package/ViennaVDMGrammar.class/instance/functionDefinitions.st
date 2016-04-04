parsers-definitions
functionDefinitions
	^ (self functions , (self accessFunctionDefinition separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second