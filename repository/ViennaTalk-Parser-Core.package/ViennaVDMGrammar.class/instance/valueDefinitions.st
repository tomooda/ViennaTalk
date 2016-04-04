parsers-definitions
valueDefinitions
	^ (self values , (self accessValueDefinition separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second