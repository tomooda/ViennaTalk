formatting-patterns and binds
objectPattern: aViennaNode
	| identifier fieldPatternList |
	identifier := self format: aViennaNode first.
	fieldPatternList := self format: aViennaNode second.
	^ 'obj_' , identifier , '('
		,
			((self needsIndent: fieldPatternList)
				ifTrue: [ String cr , indent , (self indentString: fieldPatternList) ]
				ifFalse: [ fieldPatternList ]) , ')'