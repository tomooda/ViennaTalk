code generation-definitions
explicitOperationDefinition: aViennaNode env: aDictionary
	| method opname typeNode paramsNode body varGenerator argTypeNode binds theClass |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
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
	method := self
		methodFromOperation: opname
		fromFlatBinds: binds
		body: body
		varGenerator: varGenerator
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self defineMethod: method in: theClass protocol: 'operations'.
	self
		defineLazyMethodNamed: opname
		initializer: opname , ' := ' , (self closureFromMethodSource: method binds: binds)
		in: theClass
		protocol: 'operations'