formatting-definitions
explicitOperationDefinition: aViennaNode
	| identifier1 operationType identifier2 parameters expression pre post |
	identifier1 := self format: aViennaNode first.
	operationType := self format: aViennaNode second.
	identifier2 := self format: aViennaNode third.
	parameters := self format: aViennaNode fourth.
	expression := self format: aViennaNode fifth.
	pre := aViennaNode sixth
		ifNotNil: [ :node | String cr , (self indentString: 'pre ' insertCrIfNeeded: (self format: node)) ]
		ifNil: [ '' ].
	post := aViennaNode seventh
		ifNotNil: [ :node | String cr , (self indentString: 'post ' insertCrIfNeeded: (self format: node)) ]
		ifNil: [ '' ].
	^ identifier1 , ' : ' , operationType , String cr
		, (self indentString: identifier2 , parameters , ' ==' insertCrIfNeeded: expression) , pre , post