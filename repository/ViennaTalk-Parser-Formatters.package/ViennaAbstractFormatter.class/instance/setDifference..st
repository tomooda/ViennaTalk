formatting-expressions
setDifference: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self setDifference arg: (self format: aViennaNode second)