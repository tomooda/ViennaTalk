formatting-expressions
isofbaseclassExpression: aViennaNode
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'isofbaseclass(' , cls , ',' insertCrIfNeeded: expression , ')'