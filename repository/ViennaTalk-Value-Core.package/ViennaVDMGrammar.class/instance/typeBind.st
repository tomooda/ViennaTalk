parsers-patterns
typeBind
	^ (pattern , (self operator: $:) , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]