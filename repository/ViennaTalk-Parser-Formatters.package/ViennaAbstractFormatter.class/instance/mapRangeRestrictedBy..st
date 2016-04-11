formatting-expressions
mapRangeRestrictedBy: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self rangeRestrictedBy arg: (self format: aViennaNode second)