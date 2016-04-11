bound variables-interfaces
boundVariablesExportModuleSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]