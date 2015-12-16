formatting-definitions
typeDefinition: aViennaNode
	| typeName baseType invariant |
	typeName := self format: aViennaNode first.
	baseType := self format: aViennaNode second.
	invariant := aViennaNode third ifNotNil: [ self format: aViennaNode third ].
	^ typeName , ' = '
		,
			((self needsIndent: typeName , baseType)
				ifTrue: [ self indentString: baseType ]
				ifFalse: [ baseType ])
		,
			(invariant
				ifNil: [ '' ]
				ifNotNil: [ 
					(self needsIndent: typeName , baseType , invariant)
						ifTrue: [ String cr , indent , (self indentString: invariant) ]
						ifFalse: [ String space , invariant ] ])