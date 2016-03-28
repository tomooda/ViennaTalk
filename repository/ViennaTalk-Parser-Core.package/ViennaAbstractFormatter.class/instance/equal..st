formatting-expressions
equal: aViennaNode
	^ self print: (self format: aViennaNode first) infix: '=' arg: (self format: aViennaNode second)