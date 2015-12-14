formatting-expressions
logicalEquivalence: aViennaNode
	^ self print: (self format: aViennaNode first) infix: '<=>' arg: (self format: aViennaNode second)