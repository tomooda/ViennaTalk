formatting-expressions
composition: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'comp' arg: (self format: aViennaNode second)