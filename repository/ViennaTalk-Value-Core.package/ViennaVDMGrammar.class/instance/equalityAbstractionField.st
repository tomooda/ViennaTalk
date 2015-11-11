parsers-types
equalityAbstractionField
	^ (identifier , ':-' asParser trim , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]