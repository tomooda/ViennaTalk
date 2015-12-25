parsers-statements
fieldReferenceArg
	^ ((self operator: $.) , identifier trim)
		==> [ :pair | 
			{#fieldReference:with:.
			(pair second)} ]