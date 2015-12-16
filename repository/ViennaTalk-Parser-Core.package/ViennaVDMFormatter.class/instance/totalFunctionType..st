formatting-types
totalFunctionType: aViennaNode
	^ (self format: aViennaNode first) , ' +> ' , (self format: aViennaNode second)