formatting-interfaces
exportFunctionsSignature: aViennaNode
	| functionExports |
	functionExports := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: functionExports) , ';'