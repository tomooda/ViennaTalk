parsers-definitions
stateField
	^ (identifier trim , colon , type trim)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]