bound variables-patterns and binds
boundVariablesMapMunionPattern: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]