formatting-patterns and binds
mapletPattern: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self maplet arg: (self format: aViennaNode second)