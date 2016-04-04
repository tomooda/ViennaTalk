parsers-definitions
typeDefinitions
	^ (self types , (self accessTypeDefinition separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second