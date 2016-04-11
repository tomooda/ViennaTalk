formatting-expressions
sequenceComprehension: aViennaNode
	| expression setBind guard |
	expression := self format: aViennaNode first.
	setBind := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ :node | self dot , ' ' , (self format: node) ] ifNil: [ '' ].
	^ '[' , (self indentString: expression insertCrIfNeeded: (self indentString: '| ' , setBind insertCrIfNeeded: guard))
		, ']'