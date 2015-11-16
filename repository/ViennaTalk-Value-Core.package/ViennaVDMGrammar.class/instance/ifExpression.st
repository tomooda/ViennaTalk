parsers-expressions-basics
ifExpression
	^ (((self reserved: 'if') , expression , (self reserved: 'then') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
		,
			(((self reserved: 'elseif') , expression , (self reserved: 'then') , expression)
				==> [ :quatro | 
					{(quatro second).
					(quatro fourth)} ]) star , (((self reserved: 'else') , expression) ==> #second))
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			(triple third)} ]