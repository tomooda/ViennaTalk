parsers-definitions
valueDefinition
	^ super valueDefinition
		==> [ :triple | 
			| pat body vars binder |
			pat := triple first.
			body := triple third.
			vars := pat first.
			binder := ViennaRuntimeUtil binder: pat second with: body vars: vars.
			{vars.
			'(', binder, '  ifFalse: [ViennaNoMatch signal])'} ]