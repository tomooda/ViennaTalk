parsers-types
typeName
	^ super typeName ==> [ :ast | ViennaNode label: 'TypeName' with: ast ]