parsers-definitions
typeSynonym
	^ (identifier , eq , type , invariant optional)
		==> [ :quatro | 
			{(quatro first).
			(quatro third).
			(quatro fourth)} ]