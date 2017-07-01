bound variables-types
boundVariablesUnionType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]