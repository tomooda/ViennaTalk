parsers-expressions-basics
letExpression
	^ super letExpression
		==> [ :pair | 
			'[|' , (' ' join: (pair first collect: #first)) , '|'
				, ('.' join: (pair first collect: [ :p | p first , ':=' , p second ])) , '.' , pair second , '] value' ]