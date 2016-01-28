bound variables-patterns and binds
boundVariablesFieldPatternList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]