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
					stream
						nextPutAll: '||';
						nextPutAll: (' ' join: (patterns collect: [ :pat | ' ' join: pat first ]));
						nextPut: $|.
					patterns
						with: vars
						do: [ :pat :var | 
							stream
								nextPutAll: (self binder: pat second with: var vars: pat first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					stream nextPutAll: body.
					patterns do: [ :pat | stream nextPut: $] ] ] ]