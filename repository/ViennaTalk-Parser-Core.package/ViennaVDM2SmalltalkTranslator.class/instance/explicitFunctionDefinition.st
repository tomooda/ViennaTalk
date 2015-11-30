parsers-definitions
explicitFunctionDefinition
	^ super explicitFunctionDefinition
		==> [ :array | 
			| funcName paramSets body varGenerator |
			funcName := array first.
			paramSets := array fifth.
			body := array sixth.
			varGenerator := self
				varNameGenerator: 'func'
				uniqueIn:
					{funcName.
					body}.
			{(Array with: funcName).
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: funcName;
						nextPutAll: ' := '.
					paramSets
						do: [ :params | 
							| vars |
							vars := params collect: [ :p | varGenerator value ].
							stream
								nextPut: $[;
								nextPutAll: (' ' join: (vars collect: [ :v | ' :' , v ]));
								nextPutAll: '||'.
							params
								with: vars
								do: [ :p :v | 
									p first
										do: [ :pv | 
											stream
												nextPutAll: pv;
												nextPut: Character space ] ].
							stream nextPut: $|.
							params
								with: vars
								do: [ :p :v | 
									stream
										nextPutAll: (self binder: p second with: v vars: p first);
										nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
					stream nextPutAll: body.
					paramSets do: [ :args | stream nextPut: $] ] ])} ]