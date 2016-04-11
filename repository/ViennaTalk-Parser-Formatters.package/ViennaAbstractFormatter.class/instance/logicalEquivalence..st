formatting-expressions
logicalEquivalence: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self equiv arg: (self format: aViennaNode second)