parsers-types
productType
	^ super productType ==> [ :array | ViennaNode label: 'ProductType' withAll: array ]