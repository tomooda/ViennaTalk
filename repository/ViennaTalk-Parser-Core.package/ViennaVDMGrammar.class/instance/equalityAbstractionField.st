parsers-types
equalityAbstractionField
	^ (identifier trim , (self operator: ':-') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]