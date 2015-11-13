parsers-patterns
setUnionPattern
	^ (pattern1 , (self reserved: 'union') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]