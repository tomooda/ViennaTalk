formatting-types
partialFunctionType: aViennaNode
	^ (self format: aViennaNode first) , ' ' , self partialFunction , ' ' , (self format: aViennaNode second)