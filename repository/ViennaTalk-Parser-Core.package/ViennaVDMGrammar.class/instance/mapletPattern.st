parsers-patterns
mapletPattern
	^ (pattern , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]