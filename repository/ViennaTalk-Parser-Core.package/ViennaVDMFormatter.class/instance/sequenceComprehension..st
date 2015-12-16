formatting-expressions
sequenceComprehension: aViennaNode
	| expression setBind guard |
	expression := self format: aViennaNode first.
	setBind := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	(self needsIndent: expression , setBind , guard)
		ifFalse: [ ^ '[' , expression , ' | ' , setBind , ' & ' , guard , ']' ].
	^ '[' , expression , String cr , '| '
		,
			((self needsIndent: setBind , guard)
				ifTrue: [ (self indentString: setBind) , (guard ifNotEmpty: [ String cr , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: setBind) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , ']'