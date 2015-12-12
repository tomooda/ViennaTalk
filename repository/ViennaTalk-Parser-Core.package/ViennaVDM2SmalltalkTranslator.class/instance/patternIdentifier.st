parsers-patterns
patternIdentifier
	^ super patternIdentifier
		==> [ :identifierOrNil | 
			{(identifierOrNil ifNil: [ #() ] ifNotNil: [ {identifierOrNil} ]).
			('(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')')} ]