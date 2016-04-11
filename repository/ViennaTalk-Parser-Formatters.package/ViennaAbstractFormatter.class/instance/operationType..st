formatting-types
operationType: aViennaNode
	^ (self format: aViennaNode first) , ' ' , self oparrow , ' ' , (self format: aViennaNode second)