bound variables-definitions
boundVariablesEqualDefinitionList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]