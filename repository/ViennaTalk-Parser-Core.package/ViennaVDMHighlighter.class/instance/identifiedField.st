parsers-types
identifiedField
	^ ((identifier trim , colon) and , (self decl: identifier) trim , colon , type)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]