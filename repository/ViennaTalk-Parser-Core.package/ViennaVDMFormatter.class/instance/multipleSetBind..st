formatting-patterns and binds
multipleSetBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'in set' arg: (self format: aViennaNode second)