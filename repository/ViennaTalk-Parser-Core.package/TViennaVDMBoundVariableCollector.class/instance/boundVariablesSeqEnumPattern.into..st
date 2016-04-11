bound variables-patterns and binds
boundVariablesSeqEnumPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]