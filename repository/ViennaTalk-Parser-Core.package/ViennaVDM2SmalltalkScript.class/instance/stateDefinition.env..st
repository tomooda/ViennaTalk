code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| triple |
	triple := super stateDefinition: aViennaNode env: aDictionary.
	^ triple first , triple second , '.' , String cr , triple third