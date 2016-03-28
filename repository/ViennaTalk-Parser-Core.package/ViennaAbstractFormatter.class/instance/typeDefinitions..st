formatting-definitions
typeDefinitions: aViennaNode
	^ self indentString: 'types' insertCr: (';' , String cr join: (self formatAll: aViennaNode)) , ';' , String cr