formatting-expressions
letBeExpression: aViennaNode
	| multipleBind guard expression |
	multipleBind := self format: aViennaNode first.
	guard := self format: aViennaNode second.
	expression := self format: aViennaNode third.
	(self needsIndent: multipleBind , guard , expression)
		ifFalse: [ ^ 'let ' , multipleBind , ' be st ' , guard , ' in ' , expression ].
	(self needsIndent: multipleBind , guard)
		ifFalse: [ 
			^ 'let ' , multipleBind , ' be st ' , guard , String cr , 'in'
				,
					((self needsIndent: expression)
						ifTrue: [ String cr , indent , (self indentString: expression) ]
						ifFalse: [ String space , expression ]) ].
	^ 'let'
		,
			((self needsIndent: multipleBind)
				ifTrue: [ String cr , indent , (self indentString: multipleBind) ]
				ifFalse: [ String space , multipleBind ]) , String cr , 'be st'
		,
			((self needsIndent: guard)
				ifTrue: [ String cr , indent , (self indentString: guard) ]
				ifFalse: [ String space , guard ]) , String cr , 'in'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])