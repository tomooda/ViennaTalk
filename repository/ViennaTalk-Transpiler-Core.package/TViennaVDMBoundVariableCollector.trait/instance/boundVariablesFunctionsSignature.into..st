bound variables-interfaces
boundVariablesFunctionsSignature: aViennaNode into: aSet
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]