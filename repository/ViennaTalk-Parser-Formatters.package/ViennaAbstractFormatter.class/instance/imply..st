formatting-expressions
imply: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self imply arg: (self format: aViennaNode second)