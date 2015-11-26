parsers-expressions-operators
compositionExpression: expr1 and: expr2
	^ (super compositionExpression: expr1 and: expr2) in: [ :pair | '(' , pair first , ' comp: ' , pair second , ')' ]