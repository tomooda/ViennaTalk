parsers-patterns
tuplePattern
	^ super tuplePattern
		==> [ :argPatterns | 
			| vars args |
			vars := Set new.
			argPatterns do: [ :arg | vars addAll: arg first ].
			vars := vars asArray.
			args := argPatterns collect: #second.
			{vars.
			('(ViennaRuntimeUtil matchTuple: {' , (' . ' join: args) , '})')} ]