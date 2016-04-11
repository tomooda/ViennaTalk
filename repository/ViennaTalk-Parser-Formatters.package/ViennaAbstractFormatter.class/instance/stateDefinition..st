formatting-definitions
stateDefinition: aViennaNode
	| identifier stateFieldList invariant initialisation |
	identifier := self format: aViennaNode first.
	stateFieldList := String cr join: (self formatAll: aViennaNode second).
	invariant := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	initialisation := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	^ 'state ' , identifier , ' of' , String cr , indent , (self indentString: stateFieldList) , invariant , initialisation
		, String cr , 'end'