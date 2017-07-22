code generation-definitions
extendedExplicitOperationDefinition: aViennaNode env: aDictionary
	| opname patternTypePairListNode retVar retTypeNode bodyNode body preNode postNode varGenerator binds theClass |
	opname := aViennaNode first.
	patternTypePairListNode := aViennaNode second first
		ifNil: [ Array new ].
	retVar := aViennaNode third
		ifNil: [ 'RESULT' ]
		ifNotNil: [ :node | node first ].
	retTypeNode := aViennaNode third
		ifNil: [ ViennaNode label: 'UnitType' ]
		ifNotNil: [ :node | node second ].
	bodyNode := aViennaNode fourth.
	body := self generate: bodyNode.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	binds := Array
		new: 16
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
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre:
			(preNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: preNode env: aDictionary ]
						ifFalse: [ nil ] ])
		post:
			(postNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: postNode env: aDictionary ]
						ifFalse: [ nil ] ])
		retVar: retVar
		retType: retTypeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode
		bodyNode: bodyNode.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := '
				,
					(self
						stringStreamContents: [ :stream | 
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
								ifNotEmpty: [ stream nextPutAll: ': arg1 '.
									2 to: binds size do: [ :i | 
										stream
											nextPutAll: '_: arg';
											nextPutAll: i printString;
											space ] ].
							stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'pre_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
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
				protocol: 'operations'
				node: preNode ].
	postNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'post_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
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
														ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: retVar).
															retTypeNode}} ])
										body: (self generate: postNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: postNode ]