parsers-patterns
mapEnumerationPattern
	^ super mapEnumerationPattern
		==> [ :patternPairs | 
			| vars maplets |
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
			{vars.
			('(ViennaRuntimeUtil matchMapEnumeration: {'
				, (' . ' join: (maplets collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})')} ]