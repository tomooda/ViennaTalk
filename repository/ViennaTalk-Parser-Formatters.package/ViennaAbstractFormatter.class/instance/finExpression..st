formatting-expressions
finExpression: aViennaNode
	^ '#fin(' , ', ' join: (self formatAll: aViennaNode) , ')'