formatting-expressions
setIntersection: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'inter' arg: (self format: aViennaNode second)