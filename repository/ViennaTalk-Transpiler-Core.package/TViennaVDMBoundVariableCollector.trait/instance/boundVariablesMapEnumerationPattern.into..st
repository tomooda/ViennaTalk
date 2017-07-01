bound variables-patterns and binds
boundVariablesMapEnumerationPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]