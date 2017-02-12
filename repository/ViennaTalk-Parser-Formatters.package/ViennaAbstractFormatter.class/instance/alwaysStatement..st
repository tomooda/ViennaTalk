formatting-statements
alwaysStatement: aViennaNode
	| handler statement |
	handler := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: handler)
		ifTrue: [ (self indentString: 'always' insertCr: handler) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ self indentString: 'always ' , handler , ' in' insertCrIfNeeded: statement ]