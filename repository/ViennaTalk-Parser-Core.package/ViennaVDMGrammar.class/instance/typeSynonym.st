parsers-definitions
typeSynonym
	^ (self typeIdentifier trim , eq , type , invariant optional)
		==> [ :quatro | 
			{(quatro first).
			(quatro third).
			(quatro fourth)} ]