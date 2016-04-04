parsers-expressions-basics
ifExpression
	^ ((self if , expression , self then , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ] , self elseifExpression star , ((self else , expression) ==> #second))
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			(triple third)} ]