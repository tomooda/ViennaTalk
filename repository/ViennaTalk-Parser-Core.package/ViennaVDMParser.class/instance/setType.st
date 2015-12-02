parsers-types
setType
	^ super setType ==> [ :ast | ViennaNode label: 'SetType' with: ast ]