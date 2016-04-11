formatting-expressions
arithmeticMod: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'mod' arg: (self format: aViennaNode second)