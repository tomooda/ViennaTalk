code generation-patterns
tuplePattern: aViennaNode env: aDictionary
	| argPatterns vars args |
	argPatterns := self generateAll: aViennaNode env: aDictionary.
	vars := Set new.
	argPatterns do: [ :arg | vars addAll: arg first ].
	vars := vars asArray.
	args := argPatterns collect: #second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchTuple: {' , (' . ' join: args) , '})')}