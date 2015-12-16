formatting-expressions
greaterThanOrEqual: aViennaNode
	^ self print: (self format: aViennaNode first) infix: '>=' arg: (self format: aViennaNode second)