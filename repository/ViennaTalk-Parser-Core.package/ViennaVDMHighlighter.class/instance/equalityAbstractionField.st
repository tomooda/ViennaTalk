parsers-types
equalityAbstractionField
	^ ((identifier trim , (self operator: ':-')) and , (self decl: identifier) trim , (self operator: ':-') , type)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]