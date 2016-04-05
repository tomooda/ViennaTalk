parsers-statements
setForLoop
	^ (self for , self all , pattern , self inset , expression , self do , statement)
		==> [ :array | 
			{(array third).
			(array fifth).
			(array seventh)} ]