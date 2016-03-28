formatting-interfaces
functionExport: aViennaNode
	| nameList typeVarList functionType |
	nameList := self format: aViennaNode first.
	typeVarList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	^ self indentString: nameList , typeVarList insertCrIfNeeded: ': ' , functionType