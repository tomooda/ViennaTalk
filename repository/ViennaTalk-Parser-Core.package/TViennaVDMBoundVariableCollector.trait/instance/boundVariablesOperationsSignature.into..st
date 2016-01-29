bound variables-interfaces
boundVariablesOperationsSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]