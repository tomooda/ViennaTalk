formatting-expressions
setComprehension: aViennaNode
	| expression bindList guard |
	expression := self format: aViennaNode first.
	bindList := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	(self needsIndent: expression , bindList , guard)
		ifFalse: [ ^ '{' , expression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{' , expression , String cr , '| '
		,
			((self needsIndent: bindList , guard)
				ifTrue: [ (self indentString: bindList) , (guard ifNotEmpty: [ String cr , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: bindList) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , '}'