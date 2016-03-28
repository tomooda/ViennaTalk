formatting-statements
casesStatementAlternatives: aViennaNode
	^ ',' , String cr join: (self formatAll: aViennaNode)