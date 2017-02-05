parsers-definitions
identifierTypePair
	^ super identifierTypePair
		==> [ :pair | ViennaNode label: 'IdentifierTypePair' withAll: pair ]