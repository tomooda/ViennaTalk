bound variables-patterns and binds
boundVariablesMapletPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]