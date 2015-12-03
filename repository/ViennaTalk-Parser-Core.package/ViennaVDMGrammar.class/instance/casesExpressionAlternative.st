parsers-expressions-basics
casesExpressionAlternative
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ ((others / end) not and , patternList , (self operator: '->') , expression)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]