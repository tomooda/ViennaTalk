parsers-patterns
recordPattern
	^ super recordPattern
		==> [ :tuple | 
			| constructorName argPatterns vars args |
			constructorName := tuple first.
			argPatterns := tuple second.
			vars := OrderedCollection new.
			argPatterns do: [ :arg | vars addAll: arg first ].
			args := (argPatterns collect: #second) asSet asArray.
			{vars.
			('(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: args) , '})')} ]