code generation-definitions
extendedExplicitFunctionDefinition: aViennaNode env: aDictionary
	| funcName patternTypePairList identifierTypePairList preNode postNode body varGenerator preBody postBody retType argType retValue binds |
	funcName := aViennaNode first.
	patternTypePairList := aViennaNode third first ifNil: [ Array new ].
	identifierTypePairList := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
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
				ifTrue: [ body := preBody , 'ifFalse: [ViennaPreconditionViolation signal]. ' , body
						asViennaTracingString: preNode ] ].
	postNode
		ifNotNil: [ postBody := self generate: postNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value.'
								,
									('(' , (self generate: retType env: aDictionary) , ' includes: ' , retValue
										, ') ifFalse: [ViennaRuntimeTypeError signal].' asViennaTracingString: retType)
								,
									('(' , postBody , ') ifFalse: [ViennaPostconditionViolation signal].'
										asViennaTracingString: postNode) , retValue , '] value' ]
						ifFalse: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value.'
								,
									('(' , postBody , ') ifFalse: [ViennaPostconditionViolation signal].'
										asViennaTracingString: postNode) , ' ' , retValue , '] value' ] ]
				ifFalse: [ runtimeTypeCheck = true
						ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value.'
								,
									('(' , (self generate: retType env: aDictionary) , ' includes: ' , retValue
										, ') ifFalse: [ViennaRuntimeTypeError signal].' asViennaTracingString: retType)
								, ' ' , retValue , '] value' ] ] ]
		ifNil: [ runtimeTypeCheck = true
				ifTrue: [ body := '[|' , retValue , '| ' , retValue , ' := [' , body , '] value.'
						,
							('(' , (self generate: retType env: aDictionary) , ' includes: ' , retValue
								, ') ifFalse: [ViennaRuntimeTypeError signal].' asViennaTracingString: retType)
						, ' ' , retValue , '] value' ] ].
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
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
	^ self
		stringStreamContents: [ :stream | 
			preBody
				ifNotNil: [ stream
						nextPutAll: 'pre_' , funcName;
						nextPutAll: ' := ';
						nextPutAll: preBody;
						nextPutAll: '. ' ].
			postBody
				ifNotNil: [ stream
						nextPutAll: 'post_' , funcName;
						nextPutAll: ' := ';
						nextPutAll: postBody;
						nextPutAll: '. ' ].
			stream
				nextPutAll: funcName;
				nextPutAll: ' := ';
				nextPutAll: body ]