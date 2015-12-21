formatting-definitions
accessOperationDefinition: aViennaNode
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)