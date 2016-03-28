formatting-expressions
and: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self and arg: (self format: aViennaNode second)