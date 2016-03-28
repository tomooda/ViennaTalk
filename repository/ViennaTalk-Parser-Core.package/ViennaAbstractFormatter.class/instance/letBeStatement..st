formatting-statements
letBeStatement: aViennaNode
	| multipleBind guard statement |
	multipleBind := self indentString: 'let' insertCrIfNeeded: (self format: aViennaNode first).
	guard := aViennaNode second
		ifNil: [ '' ]
		ifNotNil: [ :node | self indentString: 'be st' insertCrIfNeeded: (self format: node) ].
	statement := self indentString: 'in' insertCrIfNeeded: (self format: aViennaNode third).
	^ self noIndentString: (self noIndentString: multipleBind insertCrIfNeeded: guard) insertCrIfNeeded: statement