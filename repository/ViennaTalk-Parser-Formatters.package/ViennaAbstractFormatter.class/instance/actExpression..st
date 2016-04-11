formatting-expressions
actExpression: aViennaNode
	^ self act, '(' , ', ' join: (self formatAll: aViennaNode) , ')'