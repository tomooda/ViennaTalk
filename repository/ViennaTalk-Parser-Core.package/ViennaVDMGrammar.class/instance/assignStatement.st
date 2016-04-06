parsers-statements
assignStatement
	^ ((self basicStateDesignator , colonEq) and , (self stateDesignator , colonEq) , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]