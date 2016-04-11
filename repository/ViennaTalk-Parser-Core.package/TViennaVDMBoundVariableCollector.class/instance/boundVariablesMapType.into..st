bound variables-types
boundVariablesMapType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]