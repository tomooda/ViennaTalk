formatting-patterns and binds
seqBind: aViennaNode
	^ self print: (self format: aViennaNode first) infix: self inseq arg: (self format: aViennaNode second)