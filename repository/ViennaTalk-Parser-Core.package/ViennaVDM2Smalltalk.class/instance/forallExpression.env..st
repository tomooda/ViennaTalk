code generation-expressions
forallExpression: aViennaNode env: aDictionary
	| multibindsNode multibinds expr varGenerator |
	multibindsNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	(multibindsNode
		allSatisfy: [ :multibindNode | multibindNode first allSatisfy: [ :patternNode | patternNode label = 'PatternIdentifier' ] ])
		ifTrue: [ 
			| names |
			names := Array
				new: multibindsNode size * 2
				streamContents: [ :namesStream | multibindsNode do: [ :multibindNode | multibindNode do: [ :patternNode | namesStream nextPut: patternNode first ] ] ].
			names size = names asSet size
				ifTrue: [ 
					^ String
						new: 1024
						streamContents: [ :stream | 
							stream nextPutAll: '('.
							multibindsNode
								do: [ :multibindNode | 
									| set |
									set := self generate: multibindNode second env: aDictionary.
									multibindNode first
										do: [ :patternNode | 
											stream
												nextPutAll: set;
												nextPutAll: ' allSatisfy: [:';
												nextPutAll: patternNode first;
												nextPutAll: '|' ] ].
							stream nextPutAll: expr.
							multibindsNode do: [ :multibindNode | multibindNode first do: [ :pat | stream nextPut: $] ] ].
							stream nextPutAll: ')' ] ] ].
	multibinds := self generate: multibindsNode env: aDictionary.
	varGenerator := self varNameGenerator: 'forall' uniqueIn: (Array with: expr) , (multibinds collect: #second).
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
								nextPutAll: ' allSatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '||';
								nextPutAll: (' ' join: boundVars);
								nextPutAll: '|';
								nextPutAll: (self binder: pat with: loopVar vars: boundVars);
								nextPutAll: ' and:  [' ] ].
			stream nextPutAll: expr.
			multibinds do: [ :multibind | multibind first do: [ :pat | stream nextPutAll: ']]' ] ].
			stream nextPutAll: ')' ]