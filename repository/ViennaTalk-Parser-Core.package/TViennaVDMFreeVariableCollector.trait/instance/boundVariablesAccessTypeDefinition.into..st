bound variables-definitions
boundVariablesAccessTypeDefinition: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]