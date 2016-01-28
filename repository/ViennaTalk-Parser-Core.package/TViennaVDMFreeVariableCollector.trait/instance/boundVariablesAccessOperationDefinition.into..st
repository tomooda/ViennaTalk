bound variables-definitions
boundVariablesAccessOperationDefinition: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]