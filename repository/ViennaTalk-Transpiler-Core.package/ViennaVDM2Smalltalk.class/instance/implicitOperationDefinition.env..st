code generation-definitions
implicitOperationDefinition: aViennaNode env: aDictionary
	| opName patternTypePairListNode identifierTypePairListNode retVarName retTypeNode preNode postNode body binds varGenerator preBody postBody |
	opName := aViennaNode first.
	patternTypePairListNode := aViennaNode second first
		ifNil: [ Array new ].
	identifierTypePairListNode := aViennaNode third
		ifNil: [ {'RESULT'.
			(ViennaNode label: 'UnitType')} ].
	retVarName := identifierTypePairListNode first.
	retTypeNode := identifierTypePairListNode second.
	preNode := aViennaNode fourth second.
	postNode := aViennaNode fourth third.
	body := 'ViennaImplicitEvaluationError signal: '
		, (opName , ' is implicitly defined.') storeString.
	preNode
		ifNotNil: [ preBody := self generate: preNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ body := preBody , 'ifFalse: [ViennaPreconditionViolation signal]. '
						, body ] ].
	postBody := self generate: postNode env: aDictionary.
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{opName.
			body}.
	binds := Array
		new: 10
		streamContents: [ :stream | 
			1 to: patternTypePairListNode size by: 2 do: [ :index | 
				| patternListNode typeNode |
				patternListNode := patternTypePairListNode at: index.
				typeNode := patternTypePairListNode at: index + 1.
				patternListNode
					do: [ :patternNode | 
						stream
							nextPut:
								{patternNode.
								typeNode} ] ] ].
	body := self
		closureFromFlatBinds: binds
		body: body
		varGenerator: varGenerator
		env: aDictionary.
	preBody
		ifNotNil: [ preBody := self
				closureFromFlatBinds: binds
				body: preBody
				varGenerator: varGenerator
				env: aDictionary ].
	postBody
		ifNotNil: [ postBody := self
				closureFromFlatBinds:
					binds
						,
							((1 to: identifierTypePairListNode size by: 2)
								collect: [ :index | 
									{(ViennaNode
										label: 'PatternIdentifier'
										with: (identifierTypePairListNode at: index)).
									(identifierTypePairListNode at: index + 1)} ])
				body: postBody
				varGenerator: varGenerator
				env: aDictionary ].
	^ self
		stringStreamContents: [ :stream | 
			| env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			preNode
				ifNotNil: [ stream
						nextPutAll: 'pre_';
						nextPutAll: opName;
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
						nextPutAll: opName;
						nextPutAll: ' := ';
						nextPutAll:
							(self
								closureFromFlatBinds:
									binds
										,
											(retTypeNode label = 'UnitType'
												ifTrue: [ {} ]
												ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: retVarName).
													retTypeNode}} ])
										,
											{{(ViennaNode label: 'PatternIdentifier' with: '_State').
											nil}.
											{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
											nil}}
								body: (self generate: postNode env: env)
								varGenerator: varGenerator
								env: env);
						nextPutAll: '. ' ].
			stream
				nextPutAll: opName;
				nextPutAll: ' := ';
				nextPutAll: body ]