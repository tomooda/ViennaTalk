parsers-statements
sequenceForLoop
	^ ((self reserved: 'for') , patternBind , (self reserved: 'in') , expression , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth)} ]