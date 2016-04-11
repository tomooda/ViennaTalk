bound variables-definitions
boundVariablesValueDefinitions: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]