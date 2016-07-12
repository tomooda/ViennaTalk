code generation-definitions
explicitOperationDefinition: aViennaNode env: aDictionary
	| opname typeNode paramsNode body pre post varGenerator argTypeNode binds theClass |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
	pre := aViennaNode sixth ifNotNil: [ :preNode | self generate: preNode env: aDictionary ].
	post := aViennaNode seventh ifNotNil: [ :postNode | self generate: postNode env: aDictionary ].
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	argTypeNode := typeNode first.
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
		pre: pre
		post: post
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
									nextPutAll: i printString].
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
		protocol: 'operations'