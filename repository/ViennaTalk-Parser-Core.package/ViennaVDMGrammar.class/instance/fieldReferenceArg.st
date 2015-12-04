parsers-statements
fieldReferenceArg
	^ ((self operator: $.) , identifier)
		==> [ :pair | 
			{#fieldReference:with:.
			(pair second)} ]