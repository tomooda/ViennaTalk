formatting-interfaces
valueImport: aViennaNode
	| name type rename |
	name := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , type insertCrIfNeeded: rename