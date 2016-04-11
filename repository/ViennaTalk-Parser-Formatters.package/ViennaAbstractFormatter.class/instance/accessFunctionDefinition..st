formatting-definitions
accessFunctionDefinition: aViennaNode
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)