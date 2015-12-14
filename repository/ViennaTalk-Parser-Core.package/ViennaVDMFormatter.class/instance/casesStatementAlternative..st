formatting-statements
casesStatementAlternative: aViennaNode
	| patternList expression |
	patternList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ patternList , ' ->'
		,
			((self needsIndent: patternList , expression)
				ifTrue: [ self newlineIndentString: expression ]
				ifFalse: [ String space , expression ])