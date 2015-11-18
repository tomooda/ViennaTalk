parsers-definitions
explicitFunctionDefinition
	^ (identifier
		,
			(((lbracket , (self typeVariableIdentifier separatedBy: comma) withoutSeparators , rbracket) ==> #second) optional
				==> [ :vars | vars ifNil: [ Array new ] ]) , colon , (self partialFunctionType / self totalFunctionType) trim
		, identifier , ((lparen , (patternList optional ==> [ :ps | ps ifNil: [ Array new ] ]) , rparen) ==> #second) plus
		, (self operator: '==')
		,
			(expression / ((self reserved: 'is') , (self reserved: 'subclass') , (self reserved: 'responsibility'))
				/ ((self reserved: 'is') / (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified')))
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional
		, (((self reserved: 'measure') , name) ==> #second) optional)
		==> [ :array | 
			{(array first).
			(array second).
			(array fourth).
			(array fifth).
			(array sixth).
			(array eighth).
			(array ninth).
			(array at: 10).
			(array at: 11)} ]