formatting-patterns and binds
mapMunionPattern: aViennaNode
	^ self print: (self format: aViennaNode first) infix: 'munion' arg: (self format: aViennaNode second)