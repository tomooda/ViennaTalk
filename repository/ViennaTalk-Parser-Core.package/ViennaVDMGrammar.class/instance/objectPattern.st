parsers-patterns
objectPattern
	^ ('obj_' asParser , identifier , lparen , self fieldPatternList , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]