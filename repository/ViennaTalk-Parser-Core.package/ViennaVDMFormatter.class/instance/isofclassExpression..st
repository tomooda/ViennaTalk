formatting-expressions
isofclassExpression: aViennaNode
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'isofclass(' , cls , ',' insertCrIfNeeded: expression , ')'