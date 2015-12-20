formatting-expressions
setComprehension: aViennaNode
	| expression bindList guard |
	expression := self format: aViennaNode first.
	bindList := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ self format: aViennaNode third ] ifNil: [ '' ].
	(self needsIndent: expression , bindList , guard)
		ifFalse: [ ^ '{' , expression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{' , expression , String cr , indent , '| '
		,
			((self needsIndent: bindList , guard)
				ifTrue: [ (self indentString: bindList) , (guard ifNotEmpty: [ String cr , indent , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: bindList) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , '}'