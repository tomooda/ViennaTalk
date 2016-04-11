formatting-definitions
explicitFunctionDefinition: aViennaNode
	| identifier1 typeVariableList functionType identifier2 parametersList expression pre post measure |
	identifier1 := self format: aViennaNode first.
	typeVariableList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	identifier2 := self format: aViennaNode fourth.
	parametersList := self format: aViennaNode fifth.
	expression := self format: aViennaNode sixth.
	pre := aViennaNode seventh ifNotNil: [ :node | String cr , 'pre ' , (self format: node) ] ifNil: [ '' ].
	post := aViennaNode eighth ifNotNil: [ :node | String cr , 'post ' , (self format: node) ] ifNil: [ '' ].
	measure := aViennaNode ninth ifNotNil: [ :node | String cr , 'measure ' , (self format: node) ] ifNil: [ '' ].
	^ identifier1 , typeVariableList , ' : ' , functionType , String cr
		, (self indentString: identifier2 , parametersList , ' ==' insertCrIfNeeded: expression) , pre , post , measure