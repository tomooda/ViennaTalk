formatting-expressions
arithmeticMultiplication: aViennaNode
	^ self print: (self format: aViennaNode first) infix: '*' arg: (self format: aViennaNode second)