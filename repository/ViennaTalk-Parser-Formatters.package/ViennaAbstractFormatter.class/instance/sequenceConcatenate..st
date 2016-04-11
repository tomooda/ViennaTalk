formatting-expressions
sequenceConcatenate: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self concat arg: (self format: aViennaNode second)