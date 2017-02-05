formatting-definitions
error: aViennaNode
	^ aViennaNode first , ':' , (self format: aViennaNode second) , '->'
		, (self format: aViennaNode third)