parsers-definitions
stateField
	^ ((self decl: identifier) trim , colon , type trim)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]