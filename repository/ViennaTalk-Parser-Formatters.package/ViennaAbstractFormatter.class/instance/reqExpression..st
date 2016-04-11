formatting-expressions
reqExpression: aViennaNode
	^ '#req(' , ', ' join: (self formatAll: aViennaNode) , ')'