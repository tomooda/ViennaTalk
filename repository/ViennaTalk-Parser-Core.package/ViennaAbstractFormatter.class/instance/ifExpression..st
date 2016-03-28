formatting-expressions
ifExpression: aViennaNode
	| cond expr default elseifs |
	cond := self format: aViennaNode first first first.
	expr := self format: aViennaNode first first second.
	default := self format: aViennaNode second.
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ 
			^ (self needsIndent: cond , expr , default)
				ifTrue: [ 
					(self indentString: 'if' insertCr: cond) , String cr , (self indentString: 'then' insertCr: expr) , String cr
						, (self indentString: 'else' insertCr: default) ]
				ifFalse: [ 'if ' , cond , ' then ' , expr , ' else ' , default ] ].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , expr) , String cr , (String cr join: elseifs) , String cr
		, (self indentString: 'else' insertCr: default)