parsers-types
typeName
	^ ((self moduleIdentifier , (self operator: $`) , self typeIdentifier trim)
		==> [ :pair | 
			{(pair first).
			(pair third)} ]) / self typeIdentifier trim