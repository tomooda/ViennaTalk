formatting-expressions
setIntersection: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self inter arg: (self format: aViennaNode second)