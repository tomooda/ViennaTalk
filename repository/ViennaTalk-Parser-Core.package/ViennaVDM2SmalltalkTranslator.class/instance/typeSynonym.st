parsers-definitions
typeSynonym
	^ super typeSynonym
		==> [ :triple | 
			| ident typeExpr inv |
			ident := triple first.
			typeExpr := triple second.
			inv := triple third.
			{{ident}.
			(ident , ' := ' , typeExpr , (inv ifNotNil: [ ' inv: ' , inv ] ifNil: [ '' ]) , '.')} ]