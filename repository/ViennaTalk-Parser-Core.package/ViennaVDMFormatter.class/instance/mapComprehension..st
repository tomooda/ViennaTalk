formatting-expressions
mapComprehension: aViennaNode
	| keyExpression valueExpression bindList guard |
	keyExpression := self format: aViennaNode first.
	valueExpression := self format: aViennaNode second.
	bindList := self format: aViennaNode third.
	guard := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	(self needsIndent: keyExpression , valueExpression , bindList , guard)
		ifFalse: [ ^ '{' , keyExpression , ' |-> ' , valueExpression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{'
		,
			((self needsIndent: keyExpression , valueExpression)
				ifTrue: [ keyExpression , String cr , '|-> ' , (self indentString: valueExpression) ]
				ifFalse: [ keyExpression , ' |-> ' , valueExpression ]) , String cr , '| '
		,
			((self needsIndent: bindList , guard)
				ifTrue: [ (self indentString: bindList) , (guard ifNotEmpty: [ String cr , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: bindList) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , '}'