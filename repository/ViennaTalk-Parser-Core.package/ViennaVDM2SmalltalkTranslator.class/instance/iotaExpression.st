parsers-expressions-basics
iotaExpression
	^ super iotaExpression
		==> [ :pair | 
			| pat setOrType exprPart var |
			pat := pair first first.
			setOrType := pair first second.
			exprPart := pair second.
			var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: exprPart)) value.
			'(' , setOrType , ' detect: [ :' , var , '||' , (' ' join: pat first) , '|'
				, (ViennaRuntimeUtil binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , exprPart , '])' ]