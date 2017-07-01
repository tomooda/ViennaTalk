code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| theClass stateConstructor quin |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	quin := super stateDefinition: aViennaNode env: aDictionary.
	self
		defineMethod: 'init' , String cr , 'self viennaAtomic: [' , quin first , ']'
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: quin second
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: quin third
		in: theClass
		protocol: 'state'
		node: aViennaNode fourth.
	aDictionary
		at: 'init_' , stateConstructor
		put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr , '    ^ self ' , stateConstructor , ' applyTo: {'
				, (' . ' join: (aViennaNode second collect: #first)) , '}'
		in: theClass
		protocol: 'state'
		node: nil.
	(quin fourth notNil or: [ runtimeTypeCheck = true ])
		ifTrue: [ self
				defineMethod:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'inv';
								cr.
							quin fourth
								ifNotNil: [ stream
										nextPutAll:
											'    (' , quin fourth
												, ' value: self state) ifFalse: [self stateInvariantViolation].';
										cr ].
							runtimeTypeCheck = true
								ifTrue: [ aViennaNode second
										do: [ :triple | 
											stream
												nextPutAll: '((';
												nextPutAll: (self generate: triple third env: aDictionary);
												nextPutAll: ') includes: (';
												nextPutAll: triple first;
												nextPutAll: ')) ifFalse: [ViennaRuntimeTypeError signal].' ] ] ])
				in: theClass
				protocol: 'state'
				node: nil ].
	self
		defineMethod: 'state' , String cr , '    ^' , quin fifth
		in: theClass
		protocol: 'state'
		node: nil