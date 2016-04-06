parsers-types
equalityAbstractionField
	^ ((self decl: identifier) trim , (self operator: ':-') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]