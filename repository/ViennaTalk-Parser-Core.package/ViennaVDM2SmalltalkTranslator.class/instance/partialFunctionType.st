parsers-types
partialFunctionType
	^ super partialFunctionType
		==> [ :pair | 
			| argstype return |
			argstype := pair first.
			return := pair second.
			'(' , argstype , '->' , return , ')' ]