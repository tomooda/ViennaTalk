formatting-expressions
samebaseclassExpression: aViennaNode
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'samebaseclass(' , cls , ',' insertCrIfNeeded: expression , ')'