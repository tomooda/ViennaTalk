parsers-expressions-basics
letBeExpression
	^ ((self reserved: 'let') , multipleBind , ((self best , expression) ==> #second) optional , self in , expression)
		==> [ :quin | 
			{(quin second).
			(quin third).
			(quin fifth)} ]