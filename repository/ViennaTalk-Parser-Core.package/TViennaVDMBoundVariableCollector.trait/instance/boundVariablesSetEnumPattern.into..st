bound variables-patterns and binds
boundVariablesSetEnumPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]