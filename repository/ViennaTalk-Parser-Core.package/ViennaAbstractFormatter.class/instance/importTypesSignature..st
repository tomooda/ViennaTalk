formatting-interfaces
importTypesSignature: aViennaNode
	| typeImports |
	typeImports := self formatAll: aViennaNode.
	^ self indentString: 'types' insertCrIfNeeded: (';' , String cr join: typeImports) , ';'