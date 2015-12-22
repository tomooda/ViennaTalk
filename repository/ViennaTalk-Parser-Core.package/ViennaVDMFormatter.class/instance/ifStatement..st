formatting-statements
ifStatement: aViennaNode
	| cond statement default elseifs |
	cond := self format: aViennaNode first first first.
	statement := self format: aViennaNode first first second.
	default := self format: aViennaNode second.
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ 
			^ (self needsIndent: cond , statement , default)
				ifTrue: [ 
					(self indentString: 'if' insertCr: cond) , String cr , (self indentString: 'then' insertCr: statement) , String cr
						, (self indentString: 'else' insertCr: default) ]
				ifFalse: [ 'if ' , cond , ' then ' , statement , ' else ' , default ] ].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , statement) , String cr , (String cr join: elseifs) , String cr
		, (self indentString: 'else' insertCr: default)