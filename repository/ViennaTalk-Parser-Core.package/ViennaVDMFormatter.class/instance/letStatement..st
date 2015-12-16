formatting-statements
letStatement: aViennaNode
	| localDefinitionList statement |
	localDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: localDefinitionList , statement)
		ifTrue: [ 
			'let'
				,
					((self needsIndent: localDefinitionList)
						ifTrue: [ String cr , indent , (self indentString: localDefinitionList) ]
						ifFalse: [ String space , localDefinitionList ]) , String cr , 'in'
				,
					((self needsIndent: statement)
						ifTrue: [ String cr , indent , (self indentString: statement) ]
						ifFalse: [ String space , statement ]) ]
		ifFalse: [ 'let ' , localDefinitionList , ' in ' , statement ]