formatting-expressions
greaterThanOrEqual: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self greaterThanOrEqual arg: (self format: aViennaNode second)