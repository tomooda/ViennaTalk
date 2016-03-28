formatting-expressions
mapOrSequenceModify: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self override arg: (self format: aViennaNode second)