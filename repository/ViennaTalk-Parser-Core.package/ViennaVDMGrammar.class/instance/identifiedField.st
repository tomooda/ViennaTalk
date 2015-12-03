parsers-types
identifiedField
	^ (identifier , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]