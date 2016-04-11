code generation-patterns
mapEnumerationPattern: aViennaNode env: aDictionary
	| patternPairs |
	patternPairs := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchMapEnumeration: {'
		, (' . ' join: (patternPairs collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})'