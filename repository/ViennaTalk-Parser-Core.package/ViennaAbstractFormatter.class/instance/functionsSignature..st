formatting-interfaces
functionsSignature: aViennaNode
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: signatures) , ';'