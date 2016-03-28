formatting-expressions
arithmeticMultiplication: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self mul arg: (self format: aViennaNode second)