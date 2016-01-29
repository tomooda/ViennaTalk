bound variables-definitions
boundVariablesLocalDefinitionList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]