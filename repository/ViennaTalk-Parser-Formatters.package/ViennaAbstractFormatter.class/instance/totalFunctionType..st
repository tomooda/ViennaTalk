formatting-types
totalFunctionType: aViennaNode
	^ (self format: aViennaNode first) , ' ' , self totalFunction , ' ' , (self format: aViennaNode second)