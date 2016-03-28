formatting-types
recordTypeDefinition: aViennaNode
	| identifier fieldList invariant |
	identifier := self format: aViennaNode first.
	fieldList := self format: aViennaNode second.
	invariant := aViennaNode third
		ifNotNil: [ String cr , indent , (self indentString: (self format: aViennaNode third)) ]
		ifNil: [ '' ].
	^ identifier , ' ::'
		,
			((self needsIndent: identifier , fieldList)
				ifTrue: [ String cr , indent , (self indentString: fieldList) ]
				ifFalse: [ String space , fieldList ]) , invariant