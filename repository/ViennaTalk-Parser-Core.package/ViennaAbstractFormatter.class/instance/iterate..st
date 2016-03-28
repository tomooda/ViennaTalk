formatting-expressions
iterate: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self iterate arg: (self format: aViennaNode second)