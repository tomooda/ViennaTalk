parsers-expressions-type discriminations
typeJudgement
	^ ('is_' asParser , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]