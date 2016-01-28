bound variables-definitions
boundVariablesDefinitionBlock: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]