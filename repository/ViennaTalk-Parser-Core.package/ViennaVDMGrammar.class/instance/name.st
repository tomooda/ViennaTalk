parsers-expressions-basics
name
	^ ((self moduleIdentifier , (self operator: $`) , identifier trim)
		==> [ :pair | 
			{(pair first).
			(pair third)} ]) / identifier trim