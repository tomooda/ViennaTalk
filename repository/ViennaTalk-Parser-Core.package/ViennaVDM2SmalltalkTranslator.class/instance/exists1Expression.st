parsers-expressions-basics
exists1Expression
	^ super exists1Expression
		==> [ :pair | 
			| pat setOrType exprPart var |
			pat := pair first first.
			setOrType := pair first second.
			exprPart := pair second.
			var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: exprPart)) value.
			'(' , setOrType , ' onlyOneSatisfy: [ :' , var , '||' , (' ' join: pat first) , '|'
				, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , exprPart , '])' ]