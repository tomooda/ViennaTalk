formatting-expressions
notEqual: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self notEqual arg: (self format: aViennaNode second)