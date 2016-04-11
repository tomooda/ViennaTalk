bound variables-types
boundVariablesPartialFunctionType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]