formatting-definitions
valueDefinition: aViennaNode
	| identifier type expression |
	identifier := self format: aViennaNode first.
	type := aViennaNode second ifNotNil: [ self format: aViennaNode second ].
	expression := self format: aViennaNode third.
	^ identifier , (type ifNil: [ '' ] ifNotNil: [ ' : ' , type ]) , ' ='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])