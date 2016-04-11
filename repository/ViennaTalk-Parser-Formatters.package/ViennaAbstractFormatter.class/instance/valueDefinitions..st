formatting-definitions
valueDefinitions: aViennaNode
	^ self indentString: 'values' insertCr: (';' , String cr join: (self formatAll: aViennaNode)) , ';' , String cr