formatting-statements
casesStatementAlternative: aViennaNode
	| patternList statement |
	patternList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self indentString: patternList , ' ->' insertCrIfNeeded: statement