parsers-expressions
expression
	^ super expression
		=>> [ :start :end :node | 
			node
				start: start end: end;
				yourself ]