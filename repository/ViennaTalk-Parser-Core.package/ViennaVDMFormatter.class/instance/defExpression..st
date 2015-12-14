formatting-expressions
defExpression: aViennaNode
	| defs expression |
	defs := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'def ' , String cr , indent , (self indentString: defs) , String cr , 'in' , String cr , indent , expression