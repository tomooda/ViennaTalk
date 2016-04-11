bound variables-types
boundVariablesOptionalType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]