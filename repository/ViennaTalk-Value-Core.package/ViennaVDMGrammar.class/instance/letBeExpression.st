parsers-expressions-basics
letBeExpression
	^ ((self reserved: 'let') , multipleBind
		, (((self reserved: 'be') , (self reserved: 'st') , expression) ==> #third) optional , (self reserved: 'in')
		, expression)
		==> [ :quin | 
			{(quin second).
			(quin third).
			(quin fifth)} ]