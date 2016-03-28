formatting-interfaces
typeImport: aViennaNode
	| type rename |
	type := self format: aViennaNode first.
	rename := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: type insertCrIfNeeded: rename