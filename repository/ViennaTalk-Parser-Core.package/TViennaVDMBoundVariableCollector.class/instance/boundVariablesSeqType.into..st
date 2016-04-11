bound variables-types
boundVariablesSeqType: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]