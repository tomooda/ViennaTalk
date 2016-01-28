bound variables-patterns and binds
boundVariablesTuplePattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]