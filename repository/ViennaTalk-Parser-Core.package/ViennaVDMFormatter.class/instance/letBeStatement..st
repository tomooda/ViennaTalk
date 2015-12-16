formatting-statements
letBeStatement: aViennaNode
	| multipleBind guard statement |
	multipleBind := self format: aViennaNode first.
	guard := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: multipleBind , guard , statement)
		ifFalse: [ ^ 'let ' , multipleBind , ' be st ' , guard , ' in ' , statement ].
	(self needsIndent: multipleBind , guard)
		ifFalse: [ 
			^ 'let ' , multipleBind , ' be st ' , guard , String cr , 'in'
				,
					((self needsIndent: statement)
						ifTrue: [ String cr , indent , (self indentString: statement) ]
						ifFalse: [ String space , statement ]) ].
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
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])