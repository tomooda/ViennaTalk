parsers-expressions
casesExpression
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ (((self reserved: 'cases') , expression , (self operator: $:)) ==> #second
		,
			(((others / end) not and , patternList , (self operator: '->') , expression)
				==> [ :quatro | 
					{(quatro second).
					(quatro fourth)} ] separatedBy: (self operator: $,)) withoutSeparators
		, (((self operator: $,) , others , (self operator: '->') , expression) ==> #fourth) optional , end)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro third)} ]