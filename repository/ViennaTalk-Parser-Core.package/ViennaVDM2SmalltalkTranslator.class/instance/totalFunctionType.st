parsers-types
totalFunctionType
	^ super totalFunctionType
		==> [ :pair | 
			| argstype return |
			argstype := pair first.
			return := pair second.
			'(' , argstype , '+>' , return , ')' ]