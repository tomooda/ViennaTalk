formatting-expressions
mapMerge: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self munion arg: (self format: aViennaNode second)