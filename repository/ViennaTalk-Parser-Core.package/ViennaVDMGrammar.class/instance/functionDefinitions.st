parsers-definitions
functionDefinitions
	^ ((self reserved: 'functions') , (self accessFunctionDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second