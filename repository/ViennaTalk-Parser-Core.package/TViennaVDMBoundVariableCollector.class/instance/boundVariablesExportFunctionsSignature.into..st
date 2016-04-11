bound variables-interfaces
boundVariablesExportFunctionsSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]