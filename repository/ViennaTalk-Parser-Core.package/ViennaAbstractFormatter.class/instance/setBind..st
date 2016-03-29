formatting-patterns and binds
setBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self inset arg: (self format: aViennaNode second)