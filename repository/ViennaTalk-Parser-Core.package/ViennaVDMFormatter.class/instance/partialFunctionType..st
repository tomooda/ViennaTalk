formatting-types
partialFunctionType: aViennaNode
	^ (self format: aViennaNode first) , ' -> ' , (self format: aViennaNode second)