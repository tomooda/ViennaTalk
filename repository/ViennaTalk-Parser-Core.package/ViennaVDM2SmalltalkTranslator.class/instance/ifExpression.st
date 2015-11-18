parsers-expressions-basics
ifExpression
	^ super ifExpression
		==> [ :pair | 
			'('
				,
					(pair first
						inject: pair second
						into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ]) , ')' ]