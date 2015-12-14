formatting-expressions
activeExpression: aViennaNode
	^ '#active(' , ', ' join: (self formatAll: aViennaNode) , ')'