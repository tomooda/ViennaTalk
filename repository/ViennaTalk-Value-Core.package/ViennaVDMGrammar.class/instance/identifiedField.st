parsers-types
identifiedField
	^ (identifier , $: asParser trim , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]