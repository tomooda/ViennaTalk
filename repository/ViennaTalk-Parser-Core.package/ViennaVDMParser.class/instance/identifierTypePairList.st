parsers-definitions
identifierTypePairList
	^ super identifierTypePairList
		==> [ :array | ViennaNode label: 'IdentifierTypePairList' withAll: array ]