bound variables-definitions
boundVariablesDocument: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]