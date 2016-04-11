bound variables-definitions
boundVariablesStateDefinition: aViennaNode into: aSet
	| identifier stateFieldList invariant initialisation |
	identifier := aViennaNode first.
	stateFieldList := aViennaNode second.
	invariant := aViennaNode third.
	initialisation := aViennaNode fourth.
	aSet add: identifier.
	invariant ifNotNil: [ aSet add: 'inv_' , identifier ].
	initialisation ifNotNil: [ aSet add: 'init_' , identifier ].
	self boundVariables: stateFieldList into: aSet