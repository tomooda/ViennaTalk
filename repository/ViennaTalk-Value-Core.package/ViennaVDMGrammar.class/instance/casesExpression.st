parsers-expressions-basics
casesExpression
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ (((self reserved: 'cases') , expression , colon) ==> #second
		,
			(((others / end) not and , patternList , (self operator: '->') , expression)
				==> [ :quatro | 
					{(quatro second).
					(quatro fourth)} ] separatedBy: comma) withoutSeparators
		, ((comma , others , (self operator: '->') , expression) ==> #fourth) optional , end)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro third)} ]