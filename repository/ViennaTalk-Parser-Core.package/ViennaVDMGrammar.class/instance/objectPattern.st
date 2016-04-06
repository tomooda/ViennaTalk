parsers-patterns
objectPattern
	^ ('obj_' asParser , self typeIdentifier trim , lparen , self fieldPatternList , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]