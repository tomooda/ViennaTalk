bound variables-patterns and binds
boundVariablesTypeBindList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]