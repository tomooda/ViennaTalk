formatting-expressions
notInSet: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self notInSet arg: (self format: aViennaNode second)