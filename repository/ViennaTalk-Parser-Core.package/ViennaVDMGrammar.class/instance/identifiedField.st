parsers-types
identifiedField
	^ (identifier trim , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]