formatting-statements
setForLoop: aViennaNode
	| pattern expression statement |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: pattern , expression , statement)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do ' , statement ].
	(self needsIndent: pattern , expression)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ 'for all'
		,
			((self needsIndent: pattern)
				ifTrue: [ String cr , indent , (self indentString: pattern) ]
				ifFalse: [ String space , pattern ]) , String cr , 'in set'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])