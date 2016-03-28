formatting-expressions
casesExpressionAlternatives: aViennaNode
	^ ',' , String cr join: (self formatAll: aViennaNode)