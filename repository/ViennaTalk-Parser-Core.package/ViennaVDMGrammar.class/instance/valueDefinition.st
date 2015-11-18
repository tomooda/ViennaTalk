parsers-definitions
valueDefinition
	^ (pattern , (colon , type) optional , eq , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ]