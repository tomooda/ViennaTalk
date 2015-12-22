formatting-expressions
mapComprehension: aViennaNode
	| keyExpression valueExpression bindList guard |
	keyExpression := self format: aViennaNode first.
	valueExpression := self format: aViennaNode second.
	bindList := self format: aViennaNode third.
	guard := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | '& ' , (self format: node) ].
	(self needsIndent: keyExpression , valueExpression , bindList , guard)
		ifFalse: [ ^ '{' , keyExpression , ' |-> ' , valueExpression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{'
		,
			(self
				noIndentString: (self noIndentString: keyExpression insertCrIfNeeded: '|-> ' , valueExpression)
				insertCrIfNeeded: (self noIndentString: '| ' , bindList insertCrIfNeeded: guard)) , '}'