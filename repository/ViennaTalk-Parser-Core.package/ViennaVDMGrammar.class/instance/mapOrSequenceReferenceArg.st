parsers-statements
mapOrSequenceReferenceArg
	^ (lparen , expression , rparen)
		==> [ :triple | 
			{#mapOrSequenceReference:with:.
			(triple second)} ]