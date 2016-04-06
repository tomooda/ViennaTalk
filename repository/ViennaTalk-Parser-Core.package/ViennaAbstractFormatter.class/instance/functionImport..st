formatting-interfaces
functionImport: aViennaNode
	| name typeVariableList type rename |
	name := self format: aViennaNode first.
	typeVariableList := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | self format: node ].
	type := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | self format: node ].
	rename := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , typeVariableList , type insertCrIfNeeded: rename