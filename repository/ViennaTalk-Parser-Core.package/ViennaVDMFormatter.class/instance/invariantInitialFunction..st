formatting-definitions
invariantInitialFunction: aViennaNode
	| pattern expression |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ (self needsIndent: pattern , expression)
		ifTrue: [ pattern , ' ==' , String cr , indent , (self indentString: expression) ]
		ifFalse: [ pattern , ' == ' , expression ]