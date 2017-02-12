parsers-statements
trapStatement
	^ (self trap , pattern , self with , statement , self in , statement)
		==> [ :array | 
			{array second.
			array fourth.
			array sixth} ]