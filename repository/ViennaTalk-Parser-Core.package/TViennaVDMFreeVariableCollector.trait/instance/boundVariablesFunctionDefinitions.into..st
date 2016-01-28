bound variables-definitions
boundVariablesFunctionDefinitions: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]