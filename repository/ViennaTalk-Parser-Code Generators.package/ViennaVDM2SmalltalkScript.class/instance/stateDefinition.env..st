code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| quatro |
	quatro := super stateDefinition: aViennaNode env: aDictionary.
	^ quatro first , quatro second , '.' , String cr , quatro third
		, (quatro fourth ifNil: [ '' ] ifNotNil: [ :inv | '.' , String cr , inv ])