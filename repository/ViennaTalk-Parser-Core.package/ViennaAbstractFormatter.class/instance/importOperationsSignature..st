formatting-interfaces
importOperationsSignature: aViennaNode
	| operationImports |
	operationImports := self formatAll: aViennaNode.
	^ self indentString: 'operations' insertCrIfNeeded: (';' , String cr join: operationImports) , ';'