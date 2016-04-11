bound variables-statements
boundVariablesBlockStatement: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]