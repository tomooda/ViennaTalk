bound variables-interfaces
boundVariablesValueImport: aViennaNode into: aSet
	aSet add: aViennaNode first.
	self boundVariables: aViennaNode second into: aSet