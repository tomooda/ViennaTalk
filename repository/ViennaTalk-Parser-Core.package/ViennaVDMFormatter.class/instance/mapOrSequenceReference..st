formatting-expressions
mapOrSequenceReference: aViennaNode
	^ (self print: (self format: aViennaNode first) , '(' withChildren: {(self format: aViennaNode second)}) , ')'