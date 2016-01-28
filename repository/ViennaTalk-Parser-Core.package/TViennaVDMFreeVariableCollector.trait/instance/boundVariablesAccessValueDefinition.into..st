bound variables-definitions
boundVariablesAccessValueDefinition: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]