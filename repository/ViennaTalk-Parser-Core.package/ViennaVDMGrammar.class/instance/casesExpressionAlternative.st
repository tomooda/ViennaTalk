parsers-expressions-basics
casesExpressionAlternative
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , self arrow , expression)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]