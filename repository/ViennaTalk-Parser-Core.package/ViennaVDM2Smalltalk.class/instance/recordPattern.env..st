code generation-patterns
recordPattern: aViennaNode env: aDictionary
	| constructorName argPatterns |
	constructorName := aViennaNode first.
	constructorName label = 'LocalName'
		ifTrue: [ constructorName := constructorName first ]
		ifFalse: [ constructorName := constructorName first , '`' , constructorName second ].
	argPatterns := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: argPatterns) , '})'