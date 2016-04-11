bound variables-definitions
boundVariablesModuleBody: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]