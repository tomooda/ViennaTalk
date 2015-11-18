parsers-patterns
patternIdentifier
	^ super patternIdentifier
		==> [ :identifierOrNil | 
			{(Array with: identifierOrNil).
			('[:_value | ' , (identifierOrNil ifNil: [ 'true' ] ifNotNil: [ identifierOrNil , ':=_value.true' ]) , ']')} ]