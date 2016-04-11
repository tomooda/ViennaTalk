formatting-patterns and binds
typeBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)