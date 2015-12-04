parsers-statements
letBeStatement
	^ ((self reserved: 'let') , multipleBind
		, (((self reserved: 'be') , (self reserved: 'st') , expression) ==> #third) optional , (self reserved: 'in')
		, statement)
		==> [ :quin | 
			| binds guardExpr bodyStatement |
			binds := quin second.
			guardExpr := quin third.
			bodyStatement := quin fifth.
			{binds.
			guardExpr.
			bodyStatement} ]