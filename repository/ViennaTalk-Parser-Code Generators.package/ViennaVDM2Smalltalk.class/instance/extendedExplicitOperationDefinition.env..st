code generation-definitions
extendedExplicitOperationDefinition: aViennaNode env: aDictionary
	| opName patternTypePairList identifierTypePairList retVarName retTypeNode preNode postNode body varGenerator preBody postBody retType argType retValue binds |
	opName := aViennaNode first.
	patternTypePairList := aViennaNode second first.
	identifierTypePairList := aViennaNode third
		ifNil: [ {'RESULT'.
			(ViennaNode label: 'UnitType')} ].
	retVarName := identifierTypePairList first.
	retTypeNode := identifierTypePairList second.
	body := '[|_opContext| _opContext := thisContext. '
		, (self generate: aViennaNode fourth env: aDictionary) , '] value'.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	argType := ((2 to: patternTypePairList size by: 2)
		collect: [ :index | patternTypePairList at: index ])
		ifEmpty: [ ViennaNode label: 'UnitType' ]
		ifNotEmpty: [ :types | 
			types size = 1
				ifTrue: [ types first ]
				ifFalse: [ ViennaNode label: 'ProductType' withAll: types ] ].
	retValue := identifierTypePairList first.
	retType := identifierTypePairList second.
	preNode
		ifNotNil: [ preBody := self generate: preNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ body := preBody , 'ifFalse: [ViennaPreconditionViolation signal]. ' , body ] ].
	postNode
		ifNotNil: [ postBody := self generate: postNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value. ('
								, (self generate: retType env: aDictionary) , ' includes: ' , retValue
								, ') ifFalse: [ViennaRuntimeTypeError signal]. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. ' , retValue , '] value' ]
						ifFalse: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value. (' , postBody
								, ') ifFalse: [ViennaPostconditionViolation signal]. ' , retValue , '] value' ] ]
				ifFalse: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value. ('
								, (self generate: retType env: aDictionary) , ' includes: ' , retValue
								, ') ifFalse: [ViennaRuntimeTypeError signal]. ' , retValue , '] value' ] ] ]
		ifNil: [ runtimeTypeCheck = true
				ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value. ('
						, (self generate: retType env: aDictionary) , ' includes: ' , retValue
						, ') ifFalse: [ViennaRuntimeTypeError signal]. ' , retValue , '] value' ] ].
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{opName.
			body}.
	binds := Array
		new: 10
		streamContents: [ :stream | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				| patternListNode typeNode |
				patternListNode := patternTypePairList at: index.
				typeNode := patternTypePairList at: index + 1.
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
							((1 to: identifierTypePairList size by: 2)
								collect: [ :index | 
									{(ViennaNode label: 'PatternIdentifier' with: (identifierTypePairList at: index)).
									(identifierTypePairList at: index + 1)} ])
				body: postBody
				varGenerator: varGenerator
				env: aDictionary ].
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