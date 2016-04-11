formatting-types
inmapType: aViennaNode
	^ self inmapPrefix, (self format: aViennaNode first) , ' ' , self inmapInfix , ' ' , (self format: aViennaNode second)