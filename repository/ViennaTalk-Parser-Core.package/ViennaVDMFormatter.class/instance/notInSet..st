formatting-expressions
notInSet: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'not in set' arg: (self format: aViennaNode second)