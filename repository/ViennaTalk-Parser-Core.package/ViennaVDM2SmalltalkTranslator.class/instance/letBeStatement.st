parsers-statements
letBeStatement
	^ super letBeStatement
		==> [ :pair | 
			| multibind guard expr varGenerator |
			multibind := pair first.
			guard := pair second.
			expr := pair third.
			varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: expr).
			String
				new: 1024
				streamContents: [ :stream | 
					| patterns set vars |
					patterns := multibind first.
					set := multibind second.
					vars := patterns inject: #() into: [ :vs :pat | vs , pat first ].
					stream
						nextPutAll: '[|';
						nextPutAll: (' ' join: vars);
						nextPutAll: '|('.
					patterns
						do: [ :pat | 
							| loopVar |
							loopVar := varGenerator value.
							stream
								nextPutAll: set;
								nextPutAll: ' anySatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '|';
								nextPutAll: (self binder: pat second with: loopVar vars: pat first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					stream nextPutAll: guard.
					multibind first do: [ :pat | stream nextPut: $] ].
					stream
						nextPutAll: ') ifFalse: [NotFound signal].';
						nextPutAll: expr;
						nextPutAll: '] value' ] ]