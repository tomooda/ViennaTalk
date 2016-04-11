formatting-expressions
mapOrSequenceReference: aViennaNode
	| ref arg |
	ref := self format: aViennaNode first.
	arg := self format: aViennaNode second.
	^ (self needsIndent: ref , arg)
		ifTrue: [ ref , String cr , indent , (self indentString: '(' , arg , ')') ]
		ifFalse: [ ref , '(' , arg , ')' ]