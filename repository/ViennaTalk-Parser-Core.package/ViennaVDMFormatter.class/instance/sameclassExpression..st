formatting-expressions
sameclassExpression: aViennaNode
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'sameclass(' , cls , ',' insertCrIfNeeded: expression , ')'