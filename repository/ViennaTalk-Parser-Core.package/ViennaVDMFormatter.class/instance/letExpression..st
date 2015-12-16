formatting-expressions
letExpression: aViennaNode
	| localDefinitionList expression |
	localDefinitionList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ (self needsIndent: localDefinitionList , expression)
		ifTrue: [ 
			'let'
				,
					((self needsIndent: localDefinitionList)
						ifTrue: [ String cr , indent , (self indentString: localDefinitionList) ]
						ifFalse: [ String space , localDefinitionList ]) , String cr , 'in'
				,
					((self needsIndent: expression)
						ifTrue: [ String cr , indent , (self indentString: expression) ]
						ifFalse: [ String space , expression ]) ]
		ifFalse: [ 'let ' , localDefinitionList , ' in ' , expression ]