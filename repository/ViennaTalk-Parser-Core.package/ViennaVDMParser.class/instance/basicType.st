parsers-types
basicType
	^ super basicType ==> [ :ast | ViennaNode label: 'BasicType' with: ast ]