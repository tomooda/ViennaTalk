bound variables-definitions
boundVariablesTypeVariableList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]