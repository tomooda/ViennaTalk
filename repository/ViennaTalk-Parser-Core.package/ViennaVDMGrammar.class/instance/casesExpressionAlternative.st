parsers-expressions-basics
casesExpressionAlternative
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , (self operator: '->') , expression)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]