parsers-definitions
valueDefinitions
	^ ((self reserved: 'values') , (self accessValueDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second