parsers-expressions-basics
lambdaExpression
	^ super lambdaExpression
		==> [ :pair | 
			| patterns body varGenerator vars |
			patterns := pair first collect: #first.
			body := pair second.
			varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
			vars := patterns collect: [ :p | varGenerator value ].
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPut: $[.
					vars
						do: [ :var | 
							stream
								nextPut: $:;
								nextPutAll: var ].
					stream nextPutAll: '||'.
					patterns
						do: [ :pat | 
							pat first
								do: [ :v | 
									stream
										nextPutAll: v;
										nextPut: $  ] ].
					stream nextPut: $|.
					patterns
						with: vars
						do: [ :pat :var | 
							stream
								nextPutAll: pat second;
								nextPutAll: ' value: ';
								nextPutAll: var;
								nextPut: $. ].
					stream nextPutAll: body.
					patterns do: [ :pat | stream nextPut: $] ] ] ]