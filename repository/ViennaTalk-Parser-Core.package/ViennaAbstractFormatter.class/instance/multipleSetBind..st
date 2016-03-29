formatting-patterns and binds
multipleSetBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self inset arg: (self format: aViennaNode second)