formatting-statements
ifStatement: aViennaNode
	| cond statement default elseifs |
	cond := self format: aViennaNode first first first.
	statement := self format: aViennaNode first first second.
	default := aViennaNode second ifNotNil: [ self format: aViennaNode second ].
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ 
			^ (self needsIndent: cond , statement , (default ifNil: ['']))
				ifTrue: [ 
					(self indentString: 'if' insertCr: cond) , String cr , (self indentString: 'then' insertCr: statement) , (default ifNil: [''] ifNotNil: [String cr
						, (self indentString: 'else' insertCr: default)]) ]
				ifFalse: [ 'if ' , cond , ' then ' , statement , (default ifNil: [ '' ]  ifNotNil: [' else ' , default ]) ]].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , statement) , String cr , (String cr join: elseifs) , String cr
		, (default ifNil: [''] ifNotNil: [self indentString: 'else' insertCr: default])