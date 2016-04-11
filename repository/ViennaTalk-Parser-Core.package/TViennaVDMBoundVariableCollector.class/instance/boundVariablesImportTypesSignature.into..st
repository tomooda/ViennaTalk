bound variables-interfaces
boundVariablesImportTypesSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]