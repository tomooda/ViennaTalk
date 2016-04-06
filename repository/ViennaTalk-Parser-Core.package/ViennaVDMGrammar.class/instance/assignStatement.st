parsers-statements
assignStatement
	^ ((self basicStateDesignator , colonEq) and , self stateDesignator , colonEq , expression)
		==> [ :triple | 
			{(triple second).
			(triple fourth)} ]