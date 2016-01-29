bound variables-patterns and binds
boundVariablesPatternList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]