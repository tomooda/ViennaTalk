bound variables-definitions
boundVariablesParametersList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]