formatting-definitions
valueDefinition: aViennaNode
	| identifier type expression |
	identifier := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	expression := self format: aViennaNode third.
	^ self indentString: identifier , type , ' =' insertCrIfNeeded: expression