bound variables-types
boundVariablesFieldList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]