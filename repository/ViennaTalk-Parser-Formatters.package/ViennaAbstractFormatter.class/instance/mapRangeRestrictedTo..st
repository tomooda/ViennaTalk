formatting-expressions
mapRangeRestrictedTo: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self rangeRestrictedTo arg: (self format: aViennaNode second)