bound variables-patterns and binds
boundVariablesSeqConcPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]