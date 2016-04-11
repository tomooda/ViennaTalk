bound variables-interfaces
boundVariablesExportDefinition: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]