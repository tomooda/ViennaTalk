code generation-definitions
implicitFunctionDefinition: aViennaNode env: aDictionary
	| funcName patternTypePairListNode identifierTypePairListNode preNode postNode body binds varGenerator preBody postBody |
	funcName := aViennaNode first.
	patternTypePairListNode := aViennaNode third first.
	identifierTypePairListNode := aViennaNode fourth.
	preNode := aViennaNode fifth.
	postNode := aViennaNode sixth.
	body := 'ViennaImplicitEvaluationError signal: '
		, (funcName , ' is implicitly defined.') storeString.
	preNode
		ifNotNil: [ preBody := self generate: preNode env: aDictionary.
			runtimeAssertionCheck = true
				ifTrue: [ body := preBody , 'ifFalse: [ViennaPreconditionViolation signal]. ' , body ] ].
	postBody := self generate: postNode env: aDictionary.
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
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
									{(ViennaNode label: 'PatternIdentifier' with: (identifierTypePairListNode at: index)).
									(identifierTypePairListNode at: index + 1)} ])
				body: postBody
				varGenerator: varGenerator
				env: aDictionary ].
	^ String
		new: 1024
		streamContents: [ :stream | 
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