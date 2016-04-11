bound variables-patterns and binds
boundVariablesBindList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]