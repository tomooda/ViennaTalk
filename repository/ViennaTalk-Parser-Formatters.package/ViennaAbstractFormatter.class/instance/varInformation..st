formatting-definitions
varInformation: aViennaNode
	| mode nameList type |
	mode := aViennaNode first.
	nameList := self format: aViennaNode second.
	type := aViennaNode third
		ifNotNil: [ :node | ':' , (self format: node) ]
		ifNil: [ String new ].
	^ mode , ' ' , nameList , type