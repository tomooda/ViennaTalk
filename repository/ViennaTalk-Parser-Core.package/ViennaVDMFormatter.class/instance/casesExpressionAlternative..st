formatting-expressions
casesExpressionAlternative: aViennaNode
	| patternList expression |
	patternList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: patternList , ' ->' insertCrIfNeeded: expression