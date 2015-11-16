parsers-expressions-type discriminations
typeJudgement
	^ ((self reserved: 'is_') , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]