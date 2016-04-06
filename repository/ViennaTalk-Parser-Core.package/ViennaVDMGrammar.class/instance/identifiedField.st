parsers-types
identifiedField
	^ ((self decl: identifier) trim , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]