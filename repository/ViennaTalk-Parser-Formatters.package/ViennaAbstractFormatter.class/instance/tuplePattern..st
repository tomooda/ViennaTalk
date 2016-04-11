formatting-patterns and binds
tuplePattern: aViennaNode
	| patternList |
	patternList := self format: aViennaNode first.
	^ 'mk_('
		,
			((self needsIndent: patternList)
				ifTrue: [ String cr , indent , (self indentString: patternList) ]
				ifFalse: [ patternList ]) , ')'