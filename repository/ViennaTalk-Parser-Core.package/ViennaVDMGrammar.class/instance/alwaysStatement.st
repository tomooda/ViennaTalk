parsers-statements
alwaysStatement
	^ (self always , statement , self in , statement)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ]