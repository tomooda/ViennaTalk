bound variables-types
boundVariablesSet1Type: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]