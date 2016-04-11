formatting-expressions
maplet: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self maplet arg: (self format: aViennaNode second)