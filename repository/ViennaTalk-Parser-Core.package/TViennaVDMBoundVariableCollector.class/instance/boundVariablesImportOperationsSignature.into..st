bound variables-interfaces
boundVariablesImportOperationsSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]