formatting-expressions
letBeExpression: aViennaNode
	| multipleBind guard expression |
	multipleBind := self indentString: 'let' insertCrIfNeeded: (self format: aViennaNode first).
	guard := aViennaNode second
		ifNil: [ '' ]
		ifNotNil: [ :node | self indentString: 'be st' insertCrIfNeeded: (self format: node) ].
	expression := self indentString: 'in' insertCrIfNeeded: (self format: aViennaNode third).
	^ self noIndentString: (self noIndentString: multipleBind insertCrIfNeeded: guard) insertCrIfNeeded: expression