bound variables-definitions
boundVariablesFunctionDefinitions: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]