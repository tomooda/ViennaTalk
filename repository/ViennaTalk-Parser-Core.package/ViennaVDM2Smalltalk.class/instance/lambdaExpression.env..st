code generation-expressions
lambdaExpression: aViennaNode env: aDictionary
	| patterns body varGenerator |
	body := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
	patterns := aViennaNode first
		collect: [ :typeBind | 
			typeBind first label = 'PatternIdentifier'
				ifTrue: [ typeBind first first -> nil ]
				ifFalse: [ 
					(self boundVariables: typeBind) asArray
						->
							{(varGenerator value).
							typeBind} ] ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPut: $[.
			patterns
				do: [ :assoc | 
					stream
						nextPut: $:;
						nextPutAll: (assoc value ifNil: [ assoc key ] ifNotNil: [ assoc value first ]);
						nextPut: Character space ].
			stream nextPutAll: '||'.
			patterns
				do: [ :assoc | 
					assoc value
						ifNotNil: [ 
							stream
								nextPutAll: (' ' join: assoc key);
								nextPut: Character space ] ].
			stream nextPut: $|.
			patterns
				do: [ :assoc | 
					assoc value
						ifNotNil: [ :pair | 
							| vars value typeBindNode |
							vars := assoc key.
							value := pair first.
							typeBindNode := pair second.
							stream
								nextPutAll: (self binder: (self generate: typeBindNode first env: aDictionary) with: value vars: vars);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
			stream nextPutAll: body.
			stream nextPut: $] ]