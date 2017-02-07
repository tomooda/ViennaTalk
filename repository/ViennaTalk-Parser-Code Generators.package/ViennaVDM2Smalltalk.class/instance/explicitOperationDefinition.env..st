code generation-definitions
explicitOperationDefinition: aViennaNode env: aDictionary
	| opname typeNode paramsNode preNode postNode body varGenerator preBody postBody argTypeNode retTypeNode binds |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	body := '[|_opContext| _opContext := thisContext. '
		, (self generate: aViennaNode fifth env: aDictionary) , '] value'.
	argTypeNode := typeNode first.
	retTypeNode := typeNode second.
	preNode
		ifNotNil: [ preBody := self generate: preNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ body := preBody , ' ifFalse: [ViennaPreconditionViolation signal]. ' , body ] ].
	postNode
		ifNotNil: [ postBody := self generate: postNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|_oldState RESULT| _oldState := ' , self getStateCode , '. RESULT := ['
								, body , '] value. (' , (self generate: retTypeNode env: aDictionary)
								, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. RESULT] value' ]
						ifFalse: [ body := '[|_oldState RESULT| _oldState := ' , self getStateCode , '. RESULT := ['
								, body , '] value. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. RESULT] value' ] ]
				ifFalse: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|RESULT| RESULT := [' , body , '] value. ('
								, (self generate: retTypeNode env: aDictionary)
								, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. RESULT] value' ] ] ]
		ifNil: [ (runtimeTypeCheck = true and: [ retTypeNode label ~= 'UnitType' ])
				ifTrue: [ body := '[|RESULT| RESULT := [' , body , '] value. ('
						, (self generate: retTypeNode env: aDictionary)
						, ' includes: RESULT) ifFalse: [ViennaRuntimeTypeError signal]. RESULT] value' ] ].
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	binds := argTypeNode label = 'UnitType'
		ifTrue: [ {} ]
		ifFalse: [ argTypeNode label = 'ProductType'
				ifTrue: [ (1 to: argTypeNode size)
						collect: [ :index | 
							{(paramsNode at: index).
							(argTypeNode at: index)} ] ]
				ifFalse: [ {{paramsNode first.
					argTypeNode}} ] ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			| env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			preNode
				ifNotNil: [ stream
						nextPutAll: 'pre_';
						nextPutAll: opname;
						nextPutAll: ' := ';
						nextPutAll:
							(self
								closureFromFlatBinds:
									binds
										,
											{{(ViennaNode label: 'PatternIdentifier' with: '_State').
											nil}}
								body: (self generate: preNode env: env)
								varGenerator: varGenerator
								env: env);
						nextPutAll: '. ' ].
			postNode
				ifNotNil: [ stream
						nextPutAll: 'post_';
						nextPutAll: opname;
						nextPutAll: ' := ';
						nextPutAll:
							(self
								closureFromFlatBinds:
									binds
										,
											(retTypeNode label = 'UnitType'
												ifTrue: [ {} ]
												ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: 'RESULT').
													retTypeNode}} ])
										,
											{{(ViennaNode label: 'PatternIdentifier' with: '_State').
											nil}.
											{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
											nil}}
								body: (self generate: preNode env: env)
								varGenerator: varGenerator
								env: env);
						nextPutAll: '. ' ].
			stream
				nextPutAll: opname;
				nextPutAll: ' := ';
				nextPutAll:
					(self
						closureFromFlatBinds: binds
						body: body
						varGenerator: varGenerator
						env: aDictionary) ]