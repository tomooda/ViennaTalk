formatting-expressions
casesExpression: aViennaNode
	| value alternatives others |
	value := self format: aViennaNode first.
	alternatives := self format: aViennaNode second.
	others := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | ',' , String cr , (self format: node) ].
	^ self
		indentString:
			'cases ' , (self format: aViennaNode first) , ':' , String cr , (self format: aViennaNode second) , others , String cr
				, 'end'