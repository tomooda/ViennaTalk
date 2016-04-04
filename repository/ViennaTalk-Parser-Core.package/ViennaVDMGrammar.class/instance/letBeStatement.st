parsers-statements
letBeStatement
	^ (self let , multipleBind , ((self best , expression) ==> #second) optional , self in , statement)
		==> [ :quin | 
			| binds guardExpr bodyStatement |
			binds := quin second.
			guardExpr := quin third.
			bodyStatement := quin fifth.
			{binds.
			guardExpr.
			bodyStatement} ]