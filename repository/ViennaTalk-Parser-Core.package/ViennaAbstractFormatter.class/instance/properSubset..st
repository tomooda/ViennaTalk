formatting-expressions
properSubset: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self psubset arg: (self format: aViennaNode second)