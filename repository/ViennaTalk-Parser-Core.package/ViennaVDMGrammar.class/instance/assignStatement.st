parsers-statements
assignStatement
	^ (self stateDesignator , colonEq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]