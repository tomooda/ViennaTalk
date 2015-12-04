parsers-statements
casesStatementAlternative
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , (self operator: '->') , statement)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]