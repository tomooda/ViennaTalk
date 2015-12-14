formatting-expressions
setCardinality: aViennaNode
	^ self print: 'card' withChildren: (self formatAll: aViennaNode)