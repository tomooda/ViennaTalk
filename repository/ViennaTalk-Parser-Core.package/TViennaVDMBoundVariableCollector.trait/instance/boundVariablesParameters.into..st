bound variables-definitions
boundVariablesParameters: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]