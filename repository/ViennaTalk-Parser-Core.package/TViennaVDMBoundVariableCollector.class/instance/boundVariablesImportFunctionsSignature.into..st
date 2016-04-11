bound variables-interfaces
boundVariablesImportFunctionsSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]