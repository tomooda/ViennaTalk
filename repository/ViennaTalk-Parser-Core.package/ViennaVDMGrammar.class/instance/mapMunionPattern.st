parsers-patterns
mapMunionPattern
	^ (pattern1 , (self reserved: 'munion') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]