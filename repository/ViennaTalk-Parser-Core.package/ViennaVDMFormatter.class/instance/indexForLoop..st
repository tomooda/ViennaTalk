formatting-statements
indexForLoop: aViennaNode
	| identifier start end step statement |
	identifier := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	step := aViennaNode fourth
		ifNotNil: [ :node | self indentString: 'by ' insertCrIfNeeded: (self format: node) ]
		ifNil: [ '' ].
	statement := self format: aViennaNode fifth.
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for ' , identifier insertCrIfNeeded: '= ' , start)
				insertCrIfNeeded: (self noIndentString: (self indentString: 'to ' insertCrIfNeeded: end) insertCrIfNeeded: step))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)