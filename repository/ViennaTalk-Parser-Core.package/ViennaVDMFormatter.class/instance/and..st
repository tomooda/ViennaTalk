formatting-expressions
and: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'and' arg: (self format: aViennaNode second)