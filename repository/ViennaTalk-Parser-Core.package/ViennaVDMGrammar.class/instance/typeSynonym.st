parsers-definitions
typeSynonym
	^ (identifier trim , eq , type , invariant optional)
		==> [ :quatro | 
			{(quatro first).
			(quatro third).
			(quatro fourth)} ]