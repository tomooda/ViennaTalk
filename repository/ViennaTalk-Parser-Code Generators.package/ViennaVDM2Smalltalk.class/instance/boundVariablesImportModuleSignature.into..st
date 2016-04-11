bound variables-interfaces
boundVariablesImportModuleSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]