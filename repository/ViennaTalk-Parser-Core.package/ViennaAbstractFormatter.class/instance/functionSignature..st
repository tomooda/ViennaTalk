formatting-interfaces
functionSignature: aViennaNode
	| nameList functionType |
	nameList := self format: aViennaNode first.
	functionType := self format: aViennaNode second.
	^ nameList , ' : ' , functionType