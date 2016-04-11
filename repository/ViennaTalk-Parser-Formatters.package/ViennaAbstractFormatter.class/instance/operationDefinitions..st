formatting-definitions
operationDefinitions: aViennaNode
	^ self
		indentString: 'operations'
		insertCr: (';' , String cr , String cr join: (self formatAll: aViennaNode)) , ';' , String cr