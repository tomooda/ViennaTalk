code generation-definitions
explicitFunctionDefinition: aViennaNode env: aDictionary
	| funcName typeNode preNode postNode parametersListNode body varGenerator preBody postBody retType argTypes |
	funcName := aViennaNode first.
	typeNode := aViennaNode third.
	preNode := aViennaNode seventh.
	postNode := aViennaNode eighth.
	parametersListNode := aViennaNode fifth.
	body := self generate: aViennaNode sixth env: aDictionary.
	argTypes := parametersListNode
		collect: [ :node | 
			| t |
			t := typeNode first.
			typeNode := typeNode second.
			t ].
	retType := typeNode.
	preNode
		ifNotNil: [ 
			preBody := self generate: preNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ body := preBody , 'ifFalse: [ViennaPreconditionViolation signal]. ' , body ] ].
	postNode
		ifNotNil: [ 
			postBody := self generate: postNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ 
					runtimeTypeCheck = true
						ifTrue: [ 
							body := '[|RESULT| RESULT := [' , body , '] value. (' , (self generate: retType env: aDictionary)
								, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. RESULT] value' ]
						ifFalse: [ 
							body := '[|RESULT| RESULT := [' , body , '] value. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. RESULT] value' ] ]
				ifFalse: [ 
					runtimeTypeCheck = true
						ifTrue: [ 
							body := '[|RESULT| RESULT := [' , body , '] value. (' , (self generate: retType env: aDictionary)
								, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. RESULT] value' ] ] ]
		ifNil: [ 
			runtimeTypeCheck = true
				ifTrue: [ 
					body := '[|RESULT| RESULT := [' , body , '] value. (' , (self generate: retType env: aDictionary)
						, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. RESULT] value' ] ].
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
			body}.
	parametersListNode size to: 1 by: -1 do: [ :level | 
		| parametersNode argType binds |
		parametersNode := parametersListNode at: level.
		argType := argTypes at: level.
		binds := argType label = 'ProductType'
			ifTrue: [ 
				(1 to: parametersNode size)
					collect: [ :index | 
						{(parametersNode at: index).
						(argType at: index)} ] ]
			ifFalse: [ 
				{{(parametersNode first).
				argType}} ].
		body := self
			closureFromFlatBinds: binds
			body: body
			varGenerator: varGenerator
			env: aDictionary.
		preBody
			ifNotNil: [ 
				preBody := self
					closureFromFlatBinds: binds
					body: preBody
					varGenerator: varGenerator
					env: aDictionary ].
		postBody
			ifNotNil: [ 
				postBody := self
					closureFromFlatBinds:
						(level = parametersListNode size
							ifTrue: [ 
								binds
									,
										{{(ViennaNode label: 'PatternIdentifier' with: 'RESULT').
										typeNode}} ]
							ifFalse: [ binds ])
					body: postBody
					varGenerator: varGenerator
					env: aDictionary ] ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			preBody
				ifNotNil: [ 
					stream
						nextPutAll: 'pre_' , funcName;
						nextPutAll: ' := ';
						nextPutAll: preBody;
						nextPutAll: '. ' ].
			postBody
				ifNotNil: [ 
					stream
						nextPutAll: 'post_' , funcName;
						nextPutAll: ' := ';
						nextPutAll: postBody;
						nextPutAll: '. ' ].
			stream
				nextPutAll: funcName;
				nextPutAll: ' := ';
				nextPutAll: body ]