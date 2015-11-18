parsers-expressions-basics
lambdaExpression
	^ super lambdaExpression
		==> [ :pair | '[' , (' ' join: (pair first collect: [ :var | ':' , var first ])) , ' | ' , pair second , ']' ]