formatting-interfaces
operationSignature: aViennaNode
	| name operationType |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	^ name , operationType