formatting-expressions
subset: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self subset arg: (self format: aViennaNode second)