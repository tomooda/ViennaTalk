code generation-patterns
recordPattern: aViennaNode env: aDictionary
	| constructorName argPatterns vars args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	argPatterns := self generate: aViennaNode second env: aDictionary.
	vars := OrderedCollection new.
	argPatterns do: [ :arg | vars addAll: arg first ].
	args := (argPatterns collect: #second) asSet asArray.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: args) , '})')}