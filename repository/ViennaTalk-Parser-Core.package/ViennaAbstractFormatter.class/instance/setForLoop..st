formatting-statements
setForLoop: aViennaNode
	| pattern expression statement |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: pattern , expression , statement)
		ifFalse: [ ^ 'for all ' , pattern , ' ', self inset, ' ' , expression , ' do ' , statement ].
	(self needsIndent: pattern , expression)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for all' insertCrIfNeeded: pattern)
				insertCrIfNeeded: (self indentString: 'in set' insertCrIfNeeded: expression))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)