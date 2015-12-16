formatting-patterns and binds
setUnionPattern: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'union' arg: (self format: aViennaNode second)