parsers-definitions
stateFieldList
	^ (identifier trim , colon , type trim) star
		==> [ :array | 
			array
				collect: [ :triple | 
					{(triple first).
					(triple third)} ] ]