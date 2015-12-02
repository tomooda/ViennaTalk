parsers-types
optionalType
	^ super optionalType ==> [ :ast | ViennaNode label: 'OptionalType' with: ast ]