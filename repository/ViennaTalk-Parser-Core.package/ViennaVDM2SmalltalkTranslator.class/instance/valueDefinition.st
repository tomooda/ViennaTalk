parsers-definitions
valueDefinition
	^ super valueDefinition
		==> [ :triple | 
			| pat body vars binder |
			pat := triple first.
			body := triple third.
			vars := pat first.
			binder := pat second.
			{vars.
			('(' , binder , ' value: ' , body , ')')} ]