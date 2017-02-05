parsers-definitions
identifierTypePair
	^ (identifier trim , colon , type)
		==> [ :triple | Array with: triple first with: triple third ]