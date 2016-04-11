bound variables-types
boundVariablesSetType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]