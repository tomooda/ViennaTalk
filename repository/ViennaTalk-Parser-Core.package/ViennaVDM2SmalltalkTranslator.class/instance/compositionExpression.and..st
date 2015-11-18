parsers-expressions-operators
compositionExpression: expr1 and: expr2
	^ (super compositionExpression: expr1 and: expr2)
		in: [ :pair | '(ViennaComposition with: ' , pair first , ' with: ' , pair second , ')' ]