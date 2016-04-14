code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| theClass stateConstructor quatro |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	quatro := super stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , quatro first in: theClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: quatro second
		in: theClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: quatro third
		in: theClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr , '    ^ self ' , stateConstructor , ' applyTo: {'
				, (' . ' join: (aViennaNode second collect: #first)) , '}'
		in: theClass
		protocol: 'state'.
	quatro fourth
		ifNotNil: [ :inv | 
			self
				defineMethod: 'inv' , String cr , '    (' , inv , ' value: self state) ifFalse: [self stateInvariantViolation]'
				in: theClass
				protocol: 'state' ]