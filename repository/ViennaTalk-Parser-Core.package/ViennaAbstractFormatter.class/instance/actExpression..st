formatting-expressions
actExpression: aViennaNode
	^ '#act(' , ', ' join: (self formatAll: aViennaNode) , ')'