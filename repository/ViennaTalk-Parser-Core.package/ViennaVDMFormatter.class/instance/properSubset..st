formatting-expressions
properSubset: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'psubset' arg: (self format: aViennaNode second)