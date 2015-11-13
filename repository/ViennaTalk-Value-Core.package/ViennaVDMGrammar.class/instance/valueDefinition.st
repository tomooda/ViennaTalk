parsers-definitions
valueDefinition
	^ (pattern , ((self operator: $:) , type) optional , (self operator: $=) , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ]