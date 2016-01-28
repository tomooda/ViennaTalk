bound variables-definitions
boundVariablesAccessFunctionDefinition: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]