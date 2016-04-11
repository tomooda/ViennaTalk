formatting-definitions
equalDefinition: aViennaNode
	| patternBind expression |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: patternBind , ' =' insertCrIfNeeded: expression