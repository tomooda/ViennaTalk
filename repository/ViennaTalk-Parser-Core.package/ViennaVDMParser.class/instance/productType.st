parsers-types
productType
	^ super productType ==> [ :array | ViennaNode label: 'ProductType' with: array ]