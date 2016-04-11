formatting-interfaces
exportTypesSignature: aViennaNode
	| typeExports |
	typeExports := self formatAll: aViennaNode.
	^ self indentString: 'types' insertCrIfNeeded: (';' , String cr join: typeExports) , ';'