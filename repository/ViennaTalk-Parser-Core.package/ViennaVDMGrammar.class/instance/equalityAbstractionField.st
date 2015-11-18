parsers-types
equalityAbstractionField
	^ (identifier , (self operator: ':-') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]