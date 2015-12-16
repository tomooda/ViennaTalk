formatting-statements
whileLoop: aViennaNode
	| expression statement |
	expression := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	(self needsIndent: expression , statement)
		ifFalse: [ ^ 'while ' , expression , ' do ' , statement ].
	^ 'while'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])