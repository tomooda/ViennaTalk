formatting-definitions
explicitFunctionDefinition: aViennaNode
	| identifier1 typeVariableList functionType identifier2 parametersList expression pre post measure |
	identifier1 := self format: aViennaNode first.
	typeVariableList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	identifier2 := self format: aViennaNode fourth.
	parametersList := self format: aViennaNode fifth.
	expression := self format: aViennaNode sixth.
	pre := aViennaNode seventh ifNotNil: [ self format: aViennaNode seventh ] ifNil: [ '' ].
	post := aViennaNode eighth ifNotNil: [ self format: aViennaNode eighth ] ifNil: [ '' ].
	measure := aViennaNode ninth ifNotNil: [ self format: aViennaNode ninth ] ifNil: [ '' ].
	^ identifier1 , typeVariableList , ' : ' , functionType , String cr , identifier2 , parametersList , ' =='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , (pre ifNotEmpty: [ String cr , 'pre ' , pre ])
		, (post ifNotEmpty: [ String cr , 'post ' , post ]) , (measure ifNotEmpty: [ String cr , 'measure ' , measure ])