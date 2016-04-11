code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| theClass stateConstructor triple |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	triple := super stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , triple first in: theClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: triple second
		in: theClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: triple third
		in: theClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor