formatting-definitions
functionDefinitions: aViennaNode
	^ self
		indentString: 'functions'
		insertCr: (';' , String cr , String cr join: (self formatAll: aViennaNode)) , ';' , String cr