parsers-definitions
stateFieldList
	^ (identifier , colon , type) star
		==> [ :array | 
			array
				collect: [ :triple | 
					{(triple first).
					(triple third)} ] ]