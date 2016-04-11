formatting-definitions
typeDefinition: aViennaNode
	| typeName baseType invariant |
	typeName := self format: aViennaNode first.
	baseType := self format: aViennaNode second.
	invariant := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | self format: node ].
	^ self indentString: (self indentString: typeName , ' =' insertCrIfNeeded: baseType) insertCrIfNeeded: invariant