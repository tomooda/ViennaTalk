parsers-expressions-basics
name
	^ (identifier trim , ((self operator: $`) , identifier trim) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ 
					{(pair first).
					(pair second second)} ] ]