bound variables-interfaces
boundVariablesImportModuleSignatureAll: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]