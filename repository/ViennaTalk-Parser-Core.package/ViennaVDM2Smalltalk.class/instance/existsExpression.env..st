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
				with: aViennaNode first asArray
				do: [ :multibind :multibindNode | 
					| patterns set |
					patterns := multibind first.
					set := multibind second.
					patterns
						with: multibindNode first asArray
						do: [ :pat :patternNode | 
							| loopVar boundVars |
							loopVar := varGenerator value.
							boundVars := self boundVariables: patternNode.
							stream
								nextPutAll: set;
								nextPutAll: ' anySatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '||';
								nextPutAll: (' ' join: boundVars);
								nextPutAll: '|';
								nextPutAll: (self binder: pat with: loopVar vars: boundVars);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
			stream nextPutAll: expr.
			multibinds do: [ :multibind | multibind first do: [ :pat | stream nextPut: $] ] ].
			stream nextPutAll: ')' ]