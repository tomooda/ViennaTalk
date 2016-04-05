parsers-statements
sequenceForLoop
	^ (self for , patternBind , self in , expression , self do , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth)} ]