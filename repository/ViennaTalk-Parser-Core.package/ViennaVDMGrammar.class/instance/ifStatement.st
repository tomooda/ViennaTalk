parsers-statements
ifStatement
	^ ((self if , expression , self then , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ] , self elseifStatement star , ((self else , statement) ==> #second) optional)
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			(triple third)} ]