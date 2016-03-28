formatting-expressions
arithmeticRem: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'rem' arg: (self format: aViennaNode second)