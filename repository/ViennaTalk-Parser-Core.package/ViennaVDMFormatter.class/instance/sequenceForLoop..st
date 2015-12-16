formatting-statements
sequenceForLoop: aViennaNode
	| patternBind expression statement |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: patternBind , expression , statement)
		ifFalse: [ ^ 'for ' , patternBind , ' in ' , expression , ' do ' , statement ].
	(self needsIndent: patternBind , expression)
		ifFalse: [ ^ 'for ' , patternBind , ' in ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ 'for'
		,
			((self needsIndent: patternBind)
				ifTrue: [ String cr , indent , (self indentString: patternBind) ]
				ifFalse: [ String space , patternBind ]) , String cr , 'in'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])