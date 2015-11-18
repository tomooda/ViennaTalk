parsers-expressions-basics
mapComprehension
	^ super mapComprehension
		==> [ :quatro | 
			| keyExpr valueExpr binds guard varGenerator map |
			keyExpr := quatro first.
			valueExpr := quatro second.
			binds := quatro third.
			guard := quatro fourth.
			varGenerator := self
				varNameGenerator: 'map'
				uniqueIn:
					{keyExpr.
					valueExpr} , (binds collect: #second) , {(guard ifNil: [ '' ])}.
			map := varGenerator value.
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[ | ' , map , ' | ' , map , ' :=Dictionary new.'.
					self
						generatorCodeFromBindList: binds
						varGenerator: varGenerator
						do: [ :generatorScript | stream nextPutAll: generatorScript ].
					guard
						ifNotNil: [ 
							stream
								nextPutAll: guard;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: map;
						nextPutAll: ' at: ';
						nextPutAll: keyExpr;
						nextPutAll: ' put: ';
						nextPutAll: valueExpr.
					guard ifNotNil: [ stream nextPut: $] ].
					self generatorCodeFromBindList: binds varGenerator: varGenerator do: [ :generatorScript | stream nextPut: $] ].
					stream
						nextPut: $.;
						nextPutAll: map;
						nextPutAll: '] value' ] ]