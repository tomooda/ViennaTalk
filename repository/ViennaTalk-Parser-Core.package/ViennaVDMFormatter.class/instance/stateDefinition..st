formatting-definitions
stateDefinition: aViennaNode
	| identifier stateFieldList invariant initialisation |
	identifier := self format: aViennaNode first.
	stateFieldList := self format: aViennaNode second.
	invariant := aViennaNode third ifNotNil: [ self format: aViennaNode third ].
	initialisation := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ].
	^ 'state ' , identifier , ' of' , String cr , indent , (self indentString: stateFieldList)
		, (invariant ifNil: [ '' ] ifNotNil: [ String cr , indent , (self indentString: invariant) ])
		, (initialisation ifNil: [ '' ] ifNotNil: [ String cr , indent , (self indentString: initialisation) ]) , String cr
		, 'end'