code generation-patterns
mapEnumerationPattern: aViennaNode env: aDictionary
	| patternPairs vars maplets |
	patternPairs := self generateAll: aViennaNode env: aDictionary.
	vars := (Array
		new: 10
		streamContents: [ :stream | 
			patternPairs
				do: [ :pair | 
					stream
						nextPutAll: pair first first;
						nextPutAll: pair second first ] ]) asSet asArray.
	maplets := patternPairs
		collect: [ :pair | 
			{(pair first second).
			(pair second second)} ].
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchMapEnumeration: {'
		, (' . ' join: (maplets collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})')}