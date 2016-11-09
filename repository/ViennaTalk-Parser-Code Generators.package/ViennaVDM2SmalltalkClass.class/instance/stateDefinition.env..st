code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| theClass stateConstructor quin |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	quin := super stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , quin first in: theClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: quin second
		in: theClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: quin third
		in: theClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr , '    ^ self ' , stateConstructor , ' applyTo: {'
				, (' . ' join: (aViennaNode second collect: #first)) , '}'
		in: theClass
		protocol: 'state'.
	quin fourth
		ifNotNil: [ :inv | 
			self
				defineMethod: 'inv' , String cr , '    (' , inv , ' value: self state) ifFalse: [self stateInvariantViolation]'
				in: theClass
				protocol: 'state' ].
	self defineMethod: 'state' , String cr , '    ^' , quin fifth in: theClass protocol: 'state'