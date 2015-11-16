parsers-patterns
typeBind
	^ (pattern , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]