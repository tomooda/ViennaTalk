formatting-interfaces
operationsSignature: aViennaNode
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self indentString: 'operations' insertCrIfNeeded: (';' , String cr join: signatures) , ';'