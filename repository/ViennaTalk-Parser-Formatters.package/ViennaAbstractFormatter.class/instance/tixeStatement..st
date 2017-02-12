formatting-statements
tixeStatement: aViennaNode
	| traps statement |
	traps := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: traps)
		ifTrue: [ (self indentString: 'tixe' insertCr: traps) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ self indentString: 'tixe ' , traps , ' in' insertCrIfNeeded: statement ]