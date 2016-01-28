bound variables-patterns and binds
boundVariablesSetUnionPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]