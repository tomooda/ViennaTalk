parsers-expressions
expressionExceptEquality
	^ super expressionExceptEquality
		=>> [ :start :end :node | 
			node
				start: start end: end;
				yourself ]