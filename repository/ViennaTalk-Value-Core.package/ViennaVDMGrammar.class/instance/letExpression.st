parsers-expressions
letExpression
	| valueDefinition localDefinition |
	valueDefinition := (pattern , ($: asParser trim , type) optional , $= asParser trim , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ].
	localDefinition := valueDefinition / functionDefinition.
	^ ('let' asParser trim , localDefinition , ($, asParser trim , localDefinition) star , 'in' asParser trim , expression)
		==> [ :quin | 
			{(Array
				new: quin third size + 1
				streamContents: [ :stream | 
					stream nextPut: quin second.
					quin third do: [ :pair | stream nextPut: pair second ] ]).
			(quin fifth)} ]