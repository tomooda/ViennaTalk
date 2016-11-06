formatting-patterns and binds
multipleSeqBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self inseq arg: (self format: aViennaNode second)