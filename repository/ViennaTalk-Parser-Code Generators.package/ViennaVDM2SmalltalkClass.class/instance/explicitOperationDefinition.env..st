code generation-definitions
explicitOperationDefinition: aViennaNode env: aDictionary
	| opname typeNode paramsNode body preNode postNode varGenerator argTypeNode retTypeNode binds theClass |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	argTypeNode := typeNode first.
	retTypeNode := typeNode second.
	binds := argTypeNode label = 'UnitType'
		ifTrue: [ {} ]
		ifFalse: [ 
			argTypeNode label = 'ProductType'
				ifTrue: [ 
					(1 to: argTypeNode size)
						collect: [ :index | 
							{(paramsNode at: index).
							(argTypeNode at: index)} ] ]
				ifFalse: [ 
					{{(paramsNode first).
					argTypeNode}} ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre:
			(preNode
				ifNotNil: [ 
					runtimeAssertionCheck = true
						ifTrue: [ self generate: preNode env: aDictionary ]
						ifFalse: [ nil ] ])
		post:
			(postNode
				ifNotNil: [ 
					runtimeAssertionCheck = true
						ifTrue: [ self generate: postNode env: aDictionary ]
						ifFalse: [ nil ] ])
		varGenerator: varGenerator
		env: aDictionary.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := '
				,
					(String
						new: 1024
						streamContents: [ :stream | 
							stream nextPut: $[.
							1 to: binds size do: [ :i | 
								stream
									nextPutAll: ' :arg';
									nextPutAll: i printString ].
							binds ifNotEmpty: [ stream nextPut: $| ].
							stream
								nextPutAll: 'self ';
								nextPutAll: opname.
							binds
								ifEmpty: [ stream nextPutAll: ': nil' ]
								ifNotEmpty: [ 
									stream nextPutAll: ': arg1 '.
									2 to: binds size do: [ :i | 
										stream
											nextPutAll: '_: arg';
											nextPutAll: i printString;
											space ] ].
							stream nextPut: $] ])
		in: theClass
		protocol: 'operations'.
	preNode
		ifNotNil: [ 
			| env |
			env := aDictionary copy.
			aViennaNode stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'pre_' , opname
				initializer:
					(String
						new: 1024
						streamContents: [ :stream | 
							stream
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
												env: env) ])
				in: theClass
				protocol: 'operations' ].
	postNode
		ifNotNil: [ 
			| env |
			env := aDictionary copy.
			aViennaNode stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'post_' , opname
				initializer:
					(String
						new: 1024
						streamContents: [ :stream | 
							stream
								nextPutAll: 'post_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
										(self
												closureFromFlatBinds:
													binds
														,
															{{(ViennaNode label: 'PatternIdentifier' with: '_State').
															nil}.
															{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
															nil}}
														,
															(retTypeNode label = 'UnitType'
																ifTrue: [ {} ]
																ifFalse: [ 
																	{{(ViennaNode label: 'PatternIdentifier' with: 'RESULT').
																	retTypeNode}} ])
												body: (self generate: postNode env: env)
												varGenerator: varGenerator
												env: env) ])
				in: theClass
				protocol: 'operations' ]