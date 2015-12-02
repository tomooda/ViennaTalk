parsers-patterns
patternIdentifier
	^ super patternIdentifier ==> [ :stringOrNil | ViennaNode label: 'PatternIdentifier' with: stringOrNil ]