code generation-expressions
existsExpression: aViennaNode env: aDictionary
	| multibinds expr varGenerator |
	multibinds := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'exists' uniqueIn: (Array with: expr) , (multibinds collect: #second).
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '('.
			multibinds
				do: [ :multibind | 
					| patterns set |
					patterns := multibind first.
					set := multibind second.
					patterns
						do: [ :pat | 
							| loopVar |
							loopVar := varGenerator value.
							stream
								nextPutAll: set;
								nextPutAll: ' anySatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '||';
								nextPutAll: (' ' join: pat first);
								nextPutAll: '|';
								nextPutAll: (self binder: pat second with: loopVar vars: pat first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
			stream nextPutAll: expr.
			multibinds do: [ :multibind | multibind first do: [ :pat | stream nextPut: $] ] ].
			stream nextPutAll: ')' ]