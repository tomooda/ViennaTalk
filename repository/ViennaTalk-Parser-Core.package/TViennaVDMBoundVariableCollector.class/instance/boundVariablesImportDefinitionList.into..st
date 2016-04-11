bound variables-interfaces
boundVariablesImportDefinitionList: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]