formatting-definitions
invariantInitialFunction: aViennaNode
	| pattern expression |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: pattern , ' ==' insertCrIfNeeded: expression