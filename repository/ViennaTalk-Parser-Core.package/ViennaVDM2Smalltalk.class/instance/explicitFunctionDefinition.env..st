code generation-definitions
explicitFunctionDefinition: aViennaNode env: aDictionary
	| funcName paramSetsNode paramSets body varGenerator |
	funcName := aViennaNode first.
	paramSetsNode := aViennaNode fifth.
	paramSets := self generate: paramSetsNode env: aDictionary.
	body := self generate: aViennaNode sixth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
			body}.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: funcName;
				nextPutAll: ' := '.
			paramSets
				with: paramSetsNode asArray
				do: [ :params :paramsNode | 
					((paramsNode allSatisfy: [ :n | n label = 'PatternIdentifier' ])
						and: [ (paramsNode collect: [ :node | node first ]) asSet size = paramsNode size ])
						ifTrue: [ 
							stream nextPut: $[.
							paramsNode
								do: [ :node | 
									stream
										nextPutAll: ' :';
										nextPutAll: node first ].
							stream nextPut: $| ]
						ifFalse: [ 
							| vars |
							vars := params collect: [ :p | varGenerator value ].
							stream
								nextPut: $[;
								nextPutAll: (' ' join: (vars collect: [ :v | ' :' , v ]));
								nextPutAll: '||';
								nextPutAll: (' ' join: (self boundVariables: paramsNode) asArray);
								nextPut: $|.
							1 to: params size do: [ :index | 
								| p v n |
								p := params at: index.
								v := vars at: index.
								n := paramsNode at: index.
								stream
									nextPutAll: (self binder: p with: v vars: (self boundVariables: n) asArray);
									nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ] ].
			stream nextPutAll: body.
			paramSets do: [ :args | stream nextPut: $] ] ]