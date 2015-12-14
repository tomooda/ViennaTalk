formatting-expressions
setDifference: aViennaNode
	^ self print: (self format: aViennaNode first) infix: '\' arg: (self format: aViennaNode second)