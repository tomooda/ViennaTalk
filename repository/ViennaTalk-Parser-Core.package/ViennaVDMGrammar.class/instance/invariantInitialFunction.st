parsers-types
invariantInitialFunction
	^ (pattern , (self operator: '==') , expression)
		==> [ :triple | 
			| pat expr |
			pat := triple first.
			expr := triple third.
			{pat.
			expr} ]