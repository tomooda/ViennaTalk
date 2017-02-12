parsers-statements
tixeStatement
	^ (self tixe , self traps , self in , statement)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ]