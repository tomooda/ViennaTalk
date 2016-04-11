bound variables-types
boundVariablesProductType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]