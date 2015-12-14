formatting-expressions
arithmeticIntegerDivision: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'div' arg: (self format: aViennaNode second)