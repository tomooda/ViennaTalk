parsers-definitions
typeDefinitions
	^ ((self reserved: 'types') , (self accessTypeDefinition separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second