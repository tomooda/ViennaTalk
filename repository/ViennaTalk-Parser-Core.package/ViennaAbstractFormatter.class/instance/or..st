formatting-expressions
or: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self or arg: (self format: aViennaNode second)