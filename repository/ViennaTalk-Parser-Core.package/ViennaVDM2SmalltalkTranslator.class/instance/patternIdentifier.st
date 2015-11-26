parsers-patterns
patternIdentifier
	^ super patternIdentifier
		==> [ :identifierOrNil | 
			{(Array with: identifierOrNil).
			('(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')')} ]