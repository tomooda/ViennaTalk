bound variables-statements
boundVariablesDclStatement: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]