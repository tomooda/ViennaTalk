parsers-patterns
recordPattern
	^ super recordPattern
		==> [ :tuple | 
			| typeName argPatterns vars args |
			typeName := tuple first.
			argPatterns := tuple second.
			vars := OrderedCollection new.
			argPatterns do: [ :arg | vars addAll: arg first ].
			args := (argPatterns collect: #second) asSet asArray.
			{vars.
			('(ViennaRuntimeUtil matchRecord: ' , typeName storeString , ' args: {' , (' . ' join: args) , '})')} ]