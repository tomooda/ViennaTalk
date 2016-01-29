bound variables-definitions
boundVariablesOperationDefinitions: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]