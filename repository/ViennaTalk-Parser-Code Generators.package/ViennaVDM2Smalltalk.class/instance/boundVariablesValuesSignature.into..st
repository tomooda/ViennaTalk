bound variables-interfaces
boundVariablesValuesSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]