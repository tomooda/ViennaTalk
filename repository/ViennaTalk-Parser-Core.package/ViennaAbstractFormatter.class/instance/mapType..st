formatting-types
mapType: aViennaNode
	^ self mapPrefix, (self format: aViennaNode first) , ' ' , self mapInfix , ' ' , (self format: aViennaNode second)