code generation-definitions
stateDefinition: aViennaNode env: aDictionary in: aClass
	| stateConstructor triple |
	stateConstructor := aViennaNode first.
	triple := self stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , triple first in: aClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: triple second
		in: aClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: triple third
		in: aClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor