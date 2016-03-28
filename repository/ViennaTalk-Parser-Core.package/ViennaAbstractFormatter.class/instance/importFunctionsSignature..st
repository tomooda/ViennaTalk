formatting-interfaces
importFunctionsSignature: aViennaNode
	| functionImport |
	functionImport := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: functionImport) , ';'