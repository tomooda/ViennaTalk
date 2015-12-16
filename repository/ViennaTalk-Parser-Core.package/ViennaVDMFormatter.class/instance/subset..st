formatting-expressions
subset: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'subset' arg: (self format: aViennaNode second)