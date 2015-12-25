parsers-patterns
objectPattern
	^ ('obj_' asParser , identifier trim , lparen , self fieldPatternList , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]