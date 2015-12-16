formatting-expressions
or: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'or' arg: (self format: aViennaNode second)