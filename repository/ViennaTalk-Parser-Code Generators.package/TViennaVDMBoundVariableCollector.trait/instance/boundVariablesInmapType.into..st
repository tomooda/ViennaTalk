bound variables-types
boundVariablesInmapType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]