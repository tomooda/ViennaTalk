formatting-expressions
setComprehension: aViennaNode
	| expression bindList guard |
	expression := self format: aViennaNode first.
	bindList := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ :node | self dot , ' ' , (self format: node) ] ifNil: [ '' ].
	^ '{' , (self indentString: (self indentString: expression insertCrIfNeeded: '| ' , bindList) insertCrIfNeeded: guard)
		, '}'