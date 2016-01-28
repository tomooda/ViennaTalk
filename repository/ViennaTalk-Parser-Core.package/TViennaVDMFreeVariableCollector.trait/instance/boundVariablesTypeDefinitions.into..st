bound variables-definitions
boundVariablesTypeDefinitions: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]